# frozen_string_literal: true

require 'json'
require 'uri'
require 'openssl'
require 'three_scale_api/logging_support'
require 'rest-client'

module ThreeScaleApi
  # Http Client
  class HttpClient
    include ThreeScaleApi::LoggingSupport

    attr_reader :endpoint,
                :admin_domain,
                :provider_key,
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
      @endpoint     = URI(endpoint)
      @admin_domain = @endpoint.host
      @provider_key = provider_key
      @format       = format
      @verify_ssl   = verify_ssl
      @http         = nil
    end
  end
end
