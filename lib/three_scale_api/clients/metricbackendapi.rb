# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'
require 'three_scale_api/resources/metric'

module ThreeScaleApi
  module Clients
    # Metric resource manager wrapper for the metric entity received by REST API
    class MetricBackendApiClient < DefaultClient

      def entity_name
        'metricbackendapi'
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
