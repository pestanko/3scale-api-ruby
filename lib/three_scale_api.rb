# frozen_string_literal: true

require 'three_scale_api/http_client'
require 'three_scale_api/tools'
require 'three_scale_api/logging_support'

require 'three_scale_api/clients'

module ThreeScaleApi
  # Base class that is supposed to be used for communication with the REST API
  class Client
    attr_accessor :http_client

    APIResponseError = Tools::APIResponseError

    def headers
      headers = {
        'Accept'        => 'application/json',
        'Content-Type'  => 'application/json',
        'Authorization' => 'Basic ' + [":#{@provider_key}"].pack('m').delete("\r\n"),
      }
      headers.freeze
    end

    # @api public
    # Gets instance of the RestClient::Resource
    #
    # @return [RestClient::Resource]
    def client
      @rest_client ||= RestClient::Resource.new(@endpoint.to_s,
                                                headers:    headers,
                                                verify_ssl: @verify_ssl)
    end

    # @api public
    # Initializes base client instance for manipulation with the REST API and resources
    #
    # @param [String] endpoint 3Scale admin pages url
    # @param [String] provider_key Provider access token
    # @param [String] log_level Log level ['debug', 'info', 'warning', 'error']
    # @param [Bool] verify_ssl Default value is true
    def initialize(endpoint:, provider_key:, log_level: 'info', verify_ssl: true)
      LoggingSupport.set_level(log_level)
      @endpoint     = endpoint
      @provider_key = provider_key
      @verify_ssl   = verify_ssl
    end

    # @api public
    # Gets services manager instance
    #
    # @return [ThreeScaleApi::Clients::ServiceClient] Service manager instance
    def services
      @services_manager ||= Clients::ServiceClient.new(client)
    end

    # @api public
    # Gets accounts manager instance
    #
    # @return [ThreeScaleApi::Clients::AccountClient] Account manager instance
    def accounts
      @accounts_manager ||= Clients::AccountClient.new(client)
    end

    # @api public
    # Gets providers manager instance
    #
    # @return [ThreeScaleApi::Clients::ProviderClient] Provider manager instance
    def providers
      @providers_manager ||= Clients::ProviderClient.new(client)
    end

    # @api public
    # Gets account plans manager instance
    #
    # @return [ThreeScaleApi::Clients::AccountPlanClient] Account plans manager instance
    def account_plans
      @account_plans_manager ||= Clients::AccountPlanClient.new(client)
    end

    # @api public
    # Gets active docs manager instance
    #
    # @return [ThreeScaleApi::Clients::ActiveDocClient] active docs manager instance
    def active_docs
      @active_docs_manager ||= Clients::ActiveDocClient.new(client)
    end

    # @api public
    # Gets webhooks manager instance
    #
    # @return [ThreeScaleApi::Clients::WebHookClient] WebHooks manager instance
    def webhooks
      @webhooks_manager ||= Clients::WebHookClient.new(client)
    end

    # @api public
    # Gets settings manager instance
    #
    # @return [ThreeScaleApi::Clients::SettingsClient] Settings manager instance
    def settings
      @settings_manager ||= Clients::SettingsClient.new(client)
    end

    # @api public
    # Gets analytics manager instance
    #
    # @return [ThreeScaleApi::Clients::AnalyticsClient] Settings manager instance
    def analytics
      @settings_manager ||= Clients::AnalyticsClient.new(client)
    end

    def invoices
      @invoices ||= Clients::InvoiceClient.new(client)
    end
  end
end
