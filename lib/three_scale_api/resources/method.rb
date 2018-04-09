# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'

module ThreeScaleApi
  module Resources
    # @api public
    # Method resource wrapper for the metric entity received by the REST API
    class Method < DefaultResource
      def service
        metric.parent
      end

      def metric
        client.resource
      end

      # @api public
      # Gets application plan limits
      #
      # @return [ApplicationPlanLimitClient] Instance of the Application plan limits manager
      def application_plan_limits(app_plan)
        Clients::ApplicationPlanLimitClient.new(app_plan, metric: self)
      end
    end
  end
end
