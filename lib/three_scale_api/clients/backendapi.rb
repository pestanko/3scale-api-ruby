# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/clients/default'
require 'three_scale_api/resources/backendapi'

module ThreeScaleApi
  module Clients
    # BackendApi resource manager wrapper for the BackendApi entity received by the REST API
    class BackendApiClient < DefaultClient
      def entity_name
        'backend_api'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/backend_apis'
      end
    end
  end
end
