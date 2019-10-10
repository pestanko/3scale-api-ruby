require 'json'
require 'uri'
require 'net/http'
require 'openssl'
require 'three_scale_api/logging_support'

module ThreeScaleApi
  # Http Client
  class HttpClient
    include ThreeScaleApi::LoggingSupport

    attr_reader :endpoint,
                :admin_domain,
                :provider_key,
                :headers,
                :format

    # @api public
    # Initializes HttpClient
    #
    # @param [String] endpoint 3Scale admin endpoint
    # @param [String] provider_key Provider key
    # @param [String] format Which format
    # @param [Boolean] verify_ssl Verify ssl certificate (default is 'true')
    def initialize(endpoint:,
                   provider_key:,
                   format: :json,
                   verify_ssl: true)
      @endpoint = URI(endpoint)
      @admin_domain = @endpoint.host
      @provider_key = provider_key
      @format = format
      @verify_ssl = verify_ssl
      @headers = create_headers
      @http = nil
    end

    # @api public
    # Gets instance of the NET::HTTP client
    #
    # @return [Net::HTTP]
    def http
      @http ||= initialize_http_client
    end

    # @api public
    # Creates GET request to specified path
    #
    # @param [String] path Relative request path to endpoint
    # @param [Hash] params Optional parameters for the request
    def get(path, params: nil)
      log.debug("[GET] #{endpoint}#{path}")
      parse http.get(format_path_n_query(path, params), headers)
    end

    # @api public
    # Creates PATCH request to specified path
    #
    # @param [String] path Relative request path to endpoint
    # @param [Hash] body Request's body
    # @param [Hash] params Optional parameters for the request
    def patch(path, body:, params: nil)
      log.debug("[PATCH] #{endpoint}#{path}: #{body}")
      parse http.patch(format_path_n_query(path, params), serialize(body), headers)
    end

    # @api public
    # Creates POST request to specified path
    #
    # @param [String] path Relative request path to endpoint
    # @param [Hash] body Request's body
    # @param [Hash] params Optional parameters for the request
    def post(path, body:, params: nil)
      log.debug("[POST] #{endpoint}#{path}: #{body}")
      parse http.post(format_path_n_query(path, params), serialize(body), headers)
    end

    # @api public
    # Creates PUT request to specified path
    #
    # @param [String] path Relative request path to endpoint
    # @param [Hash] body Request's body
    # @param [Hash] params Optional parameters for the request
    def put(path, body: nil, params: nil)
      log.debug("[PUT] #{endpoint}#{path}: #{body}")
      parse http.put(format_path_n_query(path, params), serialize(body), headers)
    end

    # @api public
    # Creates DELETE request to specified path
    #
    # @param [String] path Relative request path to endpoint
    # @param [Hash] params Optional parameters for the request
    def delete(path, params: nil)
      log.debug("[DELETE] #{endpoint}#{path}")
      parse http.delete(format_path_n_query(path, params), headers)
    end

    # @api public
    # Parses entity params from the response and checks status code
    #
    # @param [::Net::HTTPResponse] response Response received using some of the request methods
    # @return [Hash] Entity params
    def parse(response)
      case response
      when Net::HTTPUnprocessableEntity, Net::HTTPSuccess then parser.decode(response.body)
      when Net::HTTPForbidden then forbidden!(response)
      when Net::HTTPNotFound then not_found!(response)
      else cannot_handle!(response)
      end
    end

    # @api public
    # Custom exception class that is thrown when the resource is not found
    class NotFoundError < StandardError; end

    # Not found - wrapper to throw NotFoundError
    #
    # @param [::Net::HTTPResponse] response Response received using some of the request methods
    # @raise [NotFoundError] Required resource hasn't been found
    def not_found!(response)
      raise NotFoundError, response
    end

    # @api public
    # Custom exception class that is thrown when the access to resource is forbidden
    class ForbiddenError < StandardError; end

    # Forbidden access - Wrapper to throw ForbiddenError
    #
    # @param [::Net::HTTPResponse] response Response received using some of the request methods
    # @raise [ForbiddenError] Access to required resource has been denied
    def forbidden!(response)
      raise ForbiddenError, response
    end

    # @api public
    # Custom exception class that is thrown when the request can't be handled
    class CannotHandleError < StandardError; end

    # Can not handle - Wrapper to throw CannotHandleError
    #
    # @param [::Net::HTTPResponse] response Response received using some of the request methods
    # @raise [CannotHandleError] Can not handle the response
    def cannot_handle!(response)
      raise CannotHandleError, response
    end

    # Takes request body and serializes it to JSON
    #
    # @param [String, Hash] body Body is serialized to JSON if it is not a string
    # @return [String] Serialized body
    def serialize(body)
      case body
      when nil then nil
      when String then body
      else parser.encode(body)
      end
    end

    # Gets parser
    #
    # Currently only supported parser is JSONParser
    def parser
      case @format
      when :json then JSONParser
      else "unknown format #{format}"
      end
    end

    protected

    # Creates headers
    #
    # @return [Hash] Generated headers
    def create_headers
      headers = {
        'Accept': "application/#{@format}",
        'Content-Type': "application/#{@format}",
        'Authorization': 'Basic ' + [":#{@provider_key}"].pack('m').delete("\r\n"),
      }
      headers.freeze
    end

    # Creates http client
    #
    # @return [Net::HTTP] Http client instance
    def initialize_http_client
      http_client = Net::HTTP.new(admin_domain, @endpoint.port)
      http_client.use_ssl = @endpoint.is_a?(URI::HTTPS)
      http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE unless @verify_ssl
      http_client
    end

    # Helper to create a string representing a path plus a query string
    def format_path_n_query(path, params)
      path = "#{path}.#{@format}"
      path += "?#{URI.encode_www_form(params)}" unless params.nil?
      path
    end

    # Json parser module
    module JSONParser
      module_function

      # @api public
      # Decodes JSON string to Hash
      #
      # @param [String] string String JSON
      # @return [Hash] Parsed JSON to Hash
      def decode(string)
        case string
        when nil, ' ', '' then nil
        else ::JSON.parse(string)
        end
      end

      # @api public
      # Creates JSON from query
      #
      # @param [Hash] query Hash query to be encoded
      # @return [String] JSON String
      def encode(query)
        ::JSON.generate(query)
      end
    end
  end
end
