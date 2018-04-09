# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Application key resource wrapper for a application key entity received by the REST API
    class ApplicationKey < DefaultResource
      def account
        application.parent
      end

      def application
        client.resource
      end

      # @api public
      # Deletes key resource
      def delete
        read unless entity
        client.delete(entity['value']) if @manager.respond_to?(:delete)
      end
    end
  end
end
