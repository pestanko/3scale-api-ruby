# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/service'
require 'three_scale_api/resources/servicebackend'

module ThreeScaleApi
  module Clients
    # Service resource manager wrapper for the service entity received by REST API for backend
    class ServiceBackendApiClient < ServiceClient

      def entity_name
        'service'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/services'
      end
    end
  end
end
