# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'
require 'three_scale_api/resources/backendapi'
require 'three_scale_api/clients/metricbackendapi'
require 'three_scale_api/clients/backendapiusage'

module ThreeScaleApi
  module Resources
    # Service resource wrapper for the service entity received by the REST API
    class BackendApiUsage < DefaultResource
    end
  end
end
