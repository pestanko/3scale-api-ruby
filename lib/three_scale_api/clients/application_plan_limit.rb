# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/application_plan_limit'

module ThreeScaleApi
  module Clients
    # Application plan limit resource manager wrapper for an application plan limit entity
    # received by the REST API
    class ApplicationPlanLimitClient < DefaultClient

      attr_reader :metric

      def entity_name
        'limit'
      end

      # @api public
      # Creates instance of the application plan resource manager
      #
      # @param [ThreeScaleQE::HttpClient] client Instance of metrics client
      def initialize(client, metric: nil)
        super(client)
        @metric = metric
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        app_id    = resource.entity_id
        metric_id = metric.entity_id
        "/admin/api/application_plans/#{app_id}/metrics/#{metric_id}/limits"
      end

      # @api public
      # Binds metric to Application plan limit
      #
      # @param [Metric] metric Metric resource
      def set_metric(metric)
        @metric = metric
      end
    end
  end
end
