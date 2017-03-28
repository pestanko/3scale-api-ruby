module ThreeScale
  module API
    module Managers
      class AccountUsers < DefaultManager
        # @api public
        # Lists users for specified account
        # @param [Fixnum] account_id Account id
        def list(account_id)
          response = http_client.get("/admin/api/accounts/#{account_id}/users")
          extract(collection: 'users', entity: 'user', from: response)
        end

        # @api public
        # Creates user for account
        # @param [Fixnum] account_id Account id
        # @param [Hash] attrs Attributes
        def create(account_id, attrs)
          body = {
              user: attrs
          }
          response = http_client.post("/admin/api/accounts/#{account_id}/users", body: body)
          extract(entity: 'user', from: response)
        end


        # @api public
        # Creates user for account
        # @param [Fixnum] account_id Account id
        # @param [Fixnum] user_id User id
        def read(account_id, user_id)
          response = http_client.get("/admin/api/accounts/#{account_id}/users/#{user_id}")
          extract(entity: 'user', from: response)
        end


        # @api public
        # Creates user for account
        # @param [Fixnum] account_id Account id
        # @param [Fixnum] user_id User id
        def delete(account_id, user_id)
          http_client.delete("/admin/api/accounts/#{account_id}/users/#{user_id}")
          true
        end
      end
    end
  end
end
