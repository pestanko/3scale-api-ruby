# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/application_key'

module ThreeScaleApi
  module Clients
    # Application key resource manager wrapper for a application key entity received by the REST API
    class ApplicationKeyClient < DefaultClient
      def entity_name
        'key'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/keys'
      end

      # @api public
      # Creates application key
      #
      # @param [Hash] attributes
      # @option attributes [String] :key Application key
      def create(attributes)
        super(attributes)
        res = _list.find { |key| attributes[:key] == key['value'] }
        log_result res
      end

      # @api public
      # Reads application key
      #
      # @param [String] key Application key
      def read(key)
        log.info("Read #{resource_name}: #{key}")
        res = _list.find { |k| key == k['value'] }
        log_result res
      end

      # @api public
      # Deletes Application key
      #
      # @param [String] key Application key
      def delete(key)
        log.info("Delete #{resource_name}: #{key}")
        rest.delete("#{url}/#{key}")
        true
      end
    end
  end
end
