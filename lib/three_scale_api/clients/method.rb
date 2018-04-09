# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/resources/method'

module ThreeScaleApi
  module Clients
    # Method resource manager wrapper for the method entity received by REST API
    class MethodClient < DefaultClient
      def service
        metric.parent
      end

      def metric
        client.resource
      end

      def entity_name
        'method'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/methods'
      end
    end
  end
end
