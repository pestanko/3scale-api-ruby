# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/clients/default'
require 'three_scale_api/clients/proxy'
require 'three_scale_api/clients/metric'
require 'three_scale_api/clients/plans'
require 'three_scale_api/clients/mapping_rule'
require 'three_scale_api/clients/plans'
require 'three_scale_api/resources/service'

module ThreeScaleApi
  module Clients
    # Service resource manager wrapper for the service entity received by the REST API
    class ServiceClient < DefaultClient
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
