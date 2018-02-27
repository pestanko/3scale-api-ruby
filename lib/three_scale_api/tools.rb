# frozen_string_literal: true

require 'logger'
require 'json'

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

    # @api public
    # Extracts Hash from response
    #
    # @param [String] collection Collection name
    # @param [String] entity Entity name
    # @param [object] from Response
    def self.extract(collection: nil, entity:, from:)
      from = JSON.parse(from)
      from = from.fetch(collection) if collection

      response = case from
                 when Array then from.map { |e| e.fetch(entity) }
                 when Hash then from.fetch(entity) { from }
                 when nil then nil # raise exception?
                 else raise "unknown #{from}"
                 end

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
