# frozen_string_literal: true

require 'three_scale_api/clients/default'

module ThreeScaleApi
  module Clients
    # Accounts(tenants) resource manager wrapper for tenant entity received by REST API
    class TenantClient < DefaultClient
      # @api public
      # Creates instance of the Accounts resource manager
      #
      # @param [ThreeScaleQE::TestClient] http_client Instance of http client
      def initialize(http_client)
        super(http_client, entity_name: 'account')
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def base_path
        + '/admin/api/accounts'
      end

      # @api public
      # Creates new resource
      #
      # @param [Hash] attributes Attributes of the created object
      # @return [DefaultResource] Created resource
      def create(attributes)
        path = '/master/api/providers'
        log.info("Create [#{path}] #{resource_name}: #{attributes}")
        response = http_client.post(path, body: attributes)
        log_result resource_instance_create(response)
      end

      # Gets resource name for specific manager
      #
      # @return [String] Manager name
      def resource_name
        'Account'
      end

      # Wrap result of the call to the instance
      #
      # @param [object] response Response from server
      def resource_instance_create(response)
        result = Tools.extract(entity: 'signup', from: response)
        account_result = result['account']
        token_result = result['access_token']
        account_result['access_token'] = token_result
        instance(entity: account_result)
      end
    end
  end
end