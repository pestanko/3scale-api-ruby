# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Referrer filter resource wrapper for a application key entity received by the REST API
    class ReferrerFilter < DefaultResource
      def account
        application.parent
      end

      def application
        client.resource
      end
    end
  end
end
