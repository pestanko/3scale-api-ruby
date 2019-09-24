# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'
require 'three_scale_api/resources/service'
require 'three_scale_api/clients/proxy'
require 'three_scale_api/clients/metric'
require 'three_scale_api/clients/plans'
require 'three_scale_api/clients/mapping_rule'


module ThreeScaleApi
  module Resources
    # Service resource wrapper for the service entity received by the REST API
    class ServiceBackendApi < Service
      def backend
        client.resource
      end
    end
  end
end
