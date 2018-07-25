# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/referrer_filter'

module ThreeScaleApi
  module Clients
    # Referrer filter resource manager wrapper for an application
    class ReferrerFilterClient < DefaultClient
      def entity_name
        'referrer_filter'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/referrer_filters'
      end

      # @api public
      # Creates application key
      #
      # @param [Hash] attributes
      # @option attributes [String] :key Application key
      def create(attributes)
        super(attributes)
        res = _list.find { |key| attributes[:referrer_filter] == key['value'] }
        log_result res
      end

      # @api public
      # Reads referrer filter
      #
      # @param [String] filter Referrer filter
      def read(filter)
        log.info("Read #{resource_name}: #{filter}")
        res = _list.find { |k| filter == k['referrer_filter'] }
        log_result res
      end
    end
  end
end
