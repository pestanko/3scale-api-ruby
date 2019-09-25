# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'
require 'three_scale_api/resources/method'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'

module ThreeScaleApi
  module Resources
    # Method resource wrapper for the method entity received by the REST API
    class MethodBackendApi < Method
      def backend
        client.resource
      end
    end
  end
end
