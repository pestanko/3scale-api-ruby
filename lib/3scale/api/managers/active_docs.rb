module ThreeScale
  module API
    module Managers
      class ActiveDocs < DefaultManager

        # @api public
        # Creates a new ActiveDocs spec
        # @param [String] name Name of the ActiveDocs spec
        # @param [String] body ActiveDocs specification in JSON format (based on Swagger)
        # @option attributes [String] :description Application Description
        # @option attributes [bool] :published Set to 'true' to publish the spec on the developer portal, or 'false' to hide it. The default value is 'true'
        # @option attributes [bool] :skip_swagger_validations Set to 'true' to skip validation of the Swagger specification, or 'false' to validate the spec. The default value is 'true'
        # @return [Hash] of created feature
        def create(name, body, **rest)
          body = {
              name: name,
              system_name: name,
              body: body,
              description: "#{name}'s specification'",
              published: true,
              skip_swagger_validations: true
          }.merge(rest)

          response = http_client.post('/admin/api/active_docs', body: body )
          extract(entity: 'api_doc', from: response)
        end


        # @api public
        # Updates the ActiveDocs spec by ID
        # @param [String] id ID of the ActiveDocs spec
        # @param [String] attr attributes to be updated
        # @return [Hash] of updated ActiveDocs
        def update(id, attr)
          response = http_client.put("/admin/api/active_docs/#{id}", body: attr)
          extract(entity: 'api_doc', from: response)
        end

        # @api public
        # Deletes an account feature.
        # @param [String] id ID of the ActiveDocs.
        # @return [bool] if true ActiveDocs was deleted
        def delete(id)
          http_client.delete("/admin/api/active_docs/#{id}")
          true
        end

        # @api public
        # Returns the list of the features available to accounts. Account features are globally scoped.
        # @return [Hash] of features
        def list
          response = http_client.get('/admin/api/active_docs')
          extract(collection: 'api_docs', entity: 'api_doc', from: response)
        end
      end
    end
  end
end