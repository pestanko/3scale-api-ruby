# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/mapping_rule'
require 'three_scale_api/resources/mapping_rulebackend'

module ThreeScaleApi
  module Clients
    # Mapping rules resource manager wrapper for the mapping rule entity received by REST API
    class MappingRuleBackendClient < MappingRuleClient
      def entity_name
        'mapping_rule'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/mapping_rules'
      end

    end
  end
end
