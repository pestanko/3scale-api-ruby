# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/policy'

module ThreeScaleApi
  module Clients
    # Policy resource manager wrapper for the proxy entity received by the REST API
    class PolicyClient < DefaultClient
      def entity_name
        nil
      end

      def collection_name
        'policies_config'
      end

      def read(params: nil)
        list(params: params)
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        "#{resource.url}/proxy/policies"
      end

      def update(attributes)
        path = url
        log.info("Update [#{path}]: #{attributes}")
        policies = {
          'policies_config' => attributes,
        }
        response = rest.put(path, body: policies)
        log_result resource_instance(response)
      end

      def add(policy = {}, prepend: false, **params)
        extracted = list.map(&:entity)
        policy.merge!(params)
        if prepend
          extracted.unshift(params)
        else
          extracted << policy
        end
        update(extracted)
      end
    end
  end
end
