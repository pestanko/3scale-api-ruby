# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Resource that represents Application Plan limit
    class ApplicationPlanLimit < DefaultResource
      def service
        metric.parent
      end

      def metric
        client.metric
      end

      def application_plan
        client.resource
      end
    end
  end
end
