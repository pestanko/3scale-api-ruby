# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/backendapi'
require 'three_scale_api/resources/backendapiusage'

module ThreeScaleApi
  module Clients
    # Backend resource manager wrapper for the backend entity received by REST API for service
    class BackendApiUsageClient < BackendApiClient
      def entity_name
        'backend_usage'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/backend_usages'
      end

      # Wrap result array of the call to the instance
      #
      # @param [object] response Response from server
      def resource_list(response)
        result = Tools.extract(entity: entity_name, from: response)
        result.map { |res| instance(entity: res) }
      end
    end
  end
end
