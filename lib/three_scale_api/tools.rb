# frozen_string_literal: true

require 'logger'

module ThreeScaleApi
  # Basic tools module
  module Tools
    # @api public
    # Checks response whether it contains error attribute
    #
    # @param [Hash] response Response from server
    def self.check_response(response)
      if (response.is_a? Hash) && (response['error'] || response['errors'])
        raise APIResponseError.new(response), (response['error'] || response['errors'])
      end
      response
    end

    def self.unwrap(from, entity_name: nil)
      case from
      when Array then from.map { |e| entity_name ? e.fetch(entity_name) : e }
      when Hash then  entity_name ? (from.fetch(entity_name) { from }) : from
      when nil then nil # raise exception?
      else raise "unknown #{from}"
      end
    end

    # @api public
    # Extracts Hash from response
    #
    # @param [String] collection Collection name
    # @param [String] entity Entity name
    # @param [object] from Response
    def self.extract(collection: nil, entity: nil, from:)
      from = from.fetch(collection) if collection
      response = unwrap(from, entity_name: entity)
      check_response(response)
    end

    # Custom error that is thrown when the
    class APIResponseError < StandardError
      attr_reader :entity

      def initialize(entity)
        @entity = entity
      end
    end
  end
end
