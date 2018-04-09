# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'

module ThreeScaleApi
  module Resources
    # Metric resource wrapper for the metric entity received by the REST API
    class Metric < DefaultResource
      def service
        client.resource
      end

      # @api public
      # Gets application plan limits
      #
      # @return [ApplicationPlanLimitClient] Instance of the Application plan limits manager
      def application_plan_limits(app_plan)
        Clients::ApplicationPlanLimitClient.new(app_plan, metric: self)
      end

      # @api public
      # Gets methods manager
      #
      # @return [MethodsManager] Instance of the Methods manager
      def methods
        Clients::MethodClient.new(self)
      end
    end
  end
end
