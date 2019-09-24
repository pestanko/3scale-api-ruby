# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/metric'
require 'three_scale_api/resources/metricbackend'

module ThreeScaleApi
  module Clients
    # Metric resource manager wrapper for the metric entity received by REST API for backend
    class MetricBackendApiClient < MetricClient

      def entity_name
        'metric'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/metrics'
      end
    end
  end
end
