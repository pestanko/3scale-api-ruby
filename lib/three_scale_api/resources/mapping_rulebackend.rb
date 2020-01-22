# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/resources/mapping_rule'
require 'three_scale_api/clients/application_plan_limit'
require 'three_scale_api/clients/method'

module ThreeScaleApi
  module Resources
    # MappingRule resource wrapper for the MappingRule entity received by the REST API
    class MappingRuleBackend < MappingRule
      def backend
        client.resource
      end
    end
  end
end
