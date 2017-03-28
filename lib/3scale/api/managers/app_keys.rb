module ThreeScale
  module API
    module Managers
      class ApplicationKeys < DefaultManager
        # @api public
        # Adds a key of an application.
        # @return [Hash]
        # @param [Fixnum] account_id ID of the account.
        # @param [Fixnum] application_id ID of the application.
        # @param [String] key app_key to be added
        def create(account_id, application_id, key)
          body = {account_id: account_id, application_id: application_id, key: key}
          response = http_client.post("/admin/api/accounts/#{account_id}/applications/#{application_id}/keys", body: body)
          extract(entity: 'key', from: response)
        end

        # @api public
        # Lists app keys of the application.
        # @return [Hash]
        # @param [Fixnum] account_id ID of the account.
        # @param [Fixnum] application_id ID of the application.
        def list(account_id, application_id)
          response = http_client.get("/admin/api/accounts/#{account_id}/applications/#{application_id}/keys")
          extract(collection: 'keys', entity: 'key', from: response)
        end

        # @api public
        # Deletes a key of an application.
        # @return [Hash]
        # @param [Fixnum] account_id ID of the account.
        # @param [Fixnum] application_id ID of the application.
        # @param [String] key app_key to be deleted.
        def delete(account_id, application_id, key)
          http_client.delete("/admin/api/accounts/#{account_id}/applications/#{application_id}/keys/#{key}")
          true
        end
      end
    end
  end
end
