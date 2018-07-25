# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/application_key'
require 'three_scale_api/clients/service'
require 'three_scale_api/clients/referrer_filter'

module ThreeScaleApi
  module Resources
    # Application resource wrapper for an application received by the REST API
    class Application < DefaultResource
      include DefaultStateResource

      # @api public
      # Gets corresponding service for the application
      #
      # @return [ThreeScaleApi::Resources::Service]
      def service
        services = Clients::ServiceClient.new(client.default_client)
        services[entity['service_id']]
      end

      def account
        client.resource
      end

      # @api public
      # Gets corresponding application plan for the application
      #
      # @return [ThreeScaleApi::Resources::ApplicationPlan]
      def application_plan
        service.application_plans[entity['plan_id']]
      end

      # @api public
      # Applications keys client instance
      #
      # @return [ApplicationKeysClient] Application keys client instance
      def keys
        Clients::ApplicationKeyClient.new(self)
      end

      # @api public
      # Referrer filters manager instance
      #
      # @return [ReferrerFilterClient] Referrer filter client instance
      def referrers
        Clients::ReferrerFilterClient.new(self)
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
