

module ThreeScale
  module API
    module Managers
      class Services < DefaultManager

        # @api public
        # @return [Hash]
        # @param [Hash] attr Service Attributes
        # @option attributes [String] :name Service Name
        def create(attr)
          response = http_client.post('/admin/api/services', body: { service: attr })
          extract(entity: 'service', from: response)
        end

        # @api public
        # @return [Array<Hash>]
        def list
          response = http_client.get('/admin/api/services')
          extract(collection: 'services', entity: 'service', from: response)
        end

        # @api public
        # @return [Hash]
        # @param [Fixnum] id Service ID
        def show(id)
          response = http_client.get("/admin/api/services/#{id}")
          extract(entity: 'service', from: response)
        end

        def delete(id)
          http_client.delete("/admin/api/services/#{id}")
          true
        end

      end
    end
  end
end