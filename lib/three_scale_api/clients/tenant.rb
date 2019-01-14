# frozen_string_literal: true

require 'three_scale_api/clients/default'

module ThreeScaleApi
  module Clients
    # Accounts(tenants) resource manager wrapper for tenant entity received by REST API
    class TenantClient < DefaultClient
      def entity_name
        'account'
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
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
        response = rest.post(path, body: attributes)
        log_result resource_instance_create(response)
      end

      # @api public
      # Updates existing tenant
      #
      # @param [Hash, DefaultResource] attributes Attributes that will be updated
      # @return [DefaultResource] Updated tenant
      def update(attributes, id: nil, method: :put)
        id ||= attributes[:id]
        path = "/master/api/providers/#{id}"
        log.info("Update [#{path}] #{resource_name}: #{attributes}")
        response = rest.method(method).call(path, body: attributes)
        log_result resource_instance(response)
      end

      # Deletes tenant
      def delete(id, params: {})
        path = '/master/api/providers'
        log.info("Delete #{resource_name}: #{id} [#{path}/#{id}]")
        rest.delete("#{path}/#{id}", params: params)
        true
      end

      # @api public
      # Triggers billing process for all developer accounts.
      #
      # @param [Hash] attributes Attributes
      def trigger_billing(attributes, provider_id: nil)
        provider_id ||= attributes[:provider_id]
        log.info("Triggering billing for tenant #{resource_name}")
        path = "/master/api/providers/#{provider_id}/billing_jobs"
        response = rest.post(path, body: attributes)
        log_result response
      end

      # @api public
      # Triggers billing process for a specific developer account
      #
      # @param [Hash] attributes Attributes
      def trigger_billing_by_account(attributes, provider_id: nil, account_id: nil)
        account_id ||= attributes[:account_id]
        provider_id ||= attributes[:provider_id]
        log.info("Triggering billing for account id: #{account_id} of tenant #{resource_name}")
        path = "/master/api/providers/#{provider_id}/accounts/#{account_id}/billing_jobs"
        response = rest.post(path, body: attributes)
        log_result response
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