# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Application plan resource wrapper for an application entity received by the REST API
    class ApplicationPlan < DefaultResource
      include DefaultPlanResource

      def service
        client.resource
      end

      # @api public
      # Gets instance of the limits manager
      #
      # @return [ApplicationPlanLimitClient] Application plan limit manager
      # @param [Metric] metric Metric resource
      def limits(metric = nil)
        Clients::ApplicationPlanLimitClient.new(self, metric: metric)
      end

      # @api public
      # Gets instance of the pricing rules client
      #
      # @param [Metric] metric Metric resource
      # @return [ApplicationPlanLimitClient] Pricing rules client
      def pricing_rules(metric = nil)
        Clients::PricingRuleClient.new(self, metric: metric)
      end
    end

    # Account resource wrapper for account entity received by REST API
    class AccountPlan < DefaultResource
      include DefaultPlanResource
    end

    # Service plan resource wrapper for proxy entity received by REST API
    class ServicePlan < DefaultResource
      include DefaultPlanResource

      def service
        client.resource
      end
    end
  end
end
