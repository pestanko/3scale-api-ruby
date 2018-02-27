# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/application_key'
require 'three_scale_api/clients/service'

module ThreeScaleApi
  module Resources
    # Application resource wrapper for an application received by the REST API
    class Application < DefaultResource
      include DefaultStateResource
      attr_accessor :account
      # @api public
      # Creates instance of the Service resource
      #
      # @param [ThreeScaleQE::TestClient] client Instance of the test client
      # @param [ApplicationClient] manager Instance of the manager
      # @param [Hash] entity Service Hash from API client
      def initialize(client, manager, entity)
        super(client, manager, entity)
        @account = manager.account
      end

      # @api public
      # Gets corresponding service for the application
      #
      # @return [ThreeScaleApi::Resources::Service]
      def service
        services = ThreeScaleApi::Clients::ServiceClient.new(client)
        services[entity['service_id']]
      end

      # @api public
      # Gets corresponding application plan for the application
      #
      # @return [ThreeScaleApi::Resources::ApplicationPlan]
      def application_plan
        service.application_plans[entity['plan_id']]
      end

      # @api public
      # Applications keys manager instance
      #
      # @return [ApplicationKeysManager] Application keys manager instance
      def keys
        manager_instance(:ApplicationKey)
      end

      # @api public
      # Accept application
      def accept
        set_state('accept')
      end

      # @api public
      # Suspend application
      def suspend
        set_state('suspend')
      end

      # @api public
      # Resume application
      def resume
        set_state('resume')
      end
    end
  end
end
