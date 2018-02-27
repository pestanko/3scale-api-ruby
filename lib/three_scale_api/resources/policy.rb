# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # @api public
    # Policy resource wrapper for policy entity received by REST API
    class Policy < DefaultResource
      # @api public
      #
      # Service instance
      # @return [Service] Service resource instance
      def service
        client.resource
      end

      # @api public
      # Updates policy
      def update
        @manager.update(entity)
      end
    end
  end
end
