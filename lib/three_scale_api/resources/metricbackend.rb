# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'
require 'three_scale_api/resources/metric'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'

module ThreeScaleApi
  module Resources
    # Metric resource wrapper for the metric entity received by the REST API
    class MetricBackendApi < Metric
      def backend
        client.resource
      end
    end
  end
end
