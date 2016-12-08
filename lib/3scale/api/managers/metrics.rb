module ThreeScale
  module API
    module Managers
      class Metrics < DefaultManager
        # @api public
        # @return [Array<Hash>]
        # @param [Fixnum] service_id Service ID
        def list(service_id)
          response = http_client.get("/admin/api/services/#{service_id}/metrics")
          extract(collection: 'metrics', entity: 'metric', from: response)
        end

        # @api public
        # @return [Hash]
        # @param [Fixnum] service_id Service ID
        # @param [Hash] attributes Metric Attributes
        # @option attributes [String] :name Metric Name
        def create(service_id, attributes)
          response = http_client.post("/admin/api/services/#{service_id}/metrics", body: { metric: attributes })
          extract(entity: 'metric', from: response)
        end

      end
    end
  end
end