# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'
require 'three_scale_api/clients/metricbackendapi'
require 'three_scale_api/clients/mapping_rulebackendapi'

module ThreeScaleApi
  module Resources
    # Service resource wrapper for the service entity received by REST API
    class BackendApi < DefaultResource
      # @api public
      # Gets the metrics manager that has bind this backend api resource
      #
      # @return [MetricsManager] Instance of the metrics manager
      def metrics
        Clients::MetricBackendApiClient.new(self)
      end

      # @api public
      # Gets the mapping rule manager that has bind this backend api resource
      #
      # @return [MappingRulesManager] Instance of the mapping rule manager
      def mapping_rules
        Clients::MappingRuleBackendClient.new(self)
      end
    end
  end
end
