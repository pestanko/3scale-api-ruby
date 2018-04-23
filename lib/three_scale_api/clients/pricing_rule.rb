# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/pricing_rule'

module ThreeScaleApi
  module Clients
    # Application plan limit resource manager wrapper for an application plan limit entity
    # received by the REST API
    class PricingRuleClient < DefaultClient

      attr_reader :metric

      def entity_name
        'pricing_rule'
      end

      # @api public
      # Creates instance of the pricing rule client
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
        app_id = resource.entity_id
        metric_id = metric.entity_id
        "/admin/api/application_plans/#{app_id}/metrics/#{metric_id}/pricing_rules"
      end

      # @api public
      # Binds metric to the ricing rule
      #
      # @param [Metric] metric Metric resource
      def set_metric(metric)
        @metric = metric
      end
    end
  end
end
