# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/policy'

module ThreeScaleApi
  module Resources
    # @api public
    # Proxy resource wrapper for proxy entity received by REST API
    class Proxy < DefaultResource
      def service
        client.resource
      end

      # @api public
      # Updates proxy
      def update
        client.update(entity)
      end
    end
  end
end
