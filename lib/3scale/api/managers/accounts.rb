module ThreeScale
  module API
    module Managers
      class Accounts < DefaultManager


        # @api public
        # @return [Hash] an Account
        # @param [String] name Account Name
        # @param [String] username User Username
        # @param [Hash] attributes User and Account Attributes
        # @option attributes [String] :email User Email
        # @option attributes [String] :password User Password
        # @option attributes [String] :account_plan_id Account Plan ID
        # @option attributes [String] :service_plan_id Service Plan ID
        # @option attributes [String] :application_plan_id Application Plan ID
        def sign_up(attributes = {}, name:, username:, **rest)
          body = { org_name: name,
                   username: username }.merge(attributes).merge(rest)
          response = http_client.post('/admin/api/signup', body: body)
          extract(entity: 'account', from: response)
        end

        # @api public
        # @return [Hash]
        def show_provider
          response = http_client.get('/admin/api/provider')
          extract(entity: 'account', from: response)
        end

        # @api public
        # @return [Array<Hash>]
        def list
          response = http_client.get('/admin/api/accounts')
          extract(collection: 'accounts', entity: 'account', from: response)
        end

        # @api public
        # @return [Hash]
        # @param [Fixnum] id Account id
        def show(id)
          response = http_client.get("/admin/api/accounts/#{id}")
          extract(entity: 'account', from: response)
        end

        # @api public
        # @return [Array<Hash>]
        def find(attr)
          response = http_client.get('/admin/api/accounts/find', params: attr)
          extract(entity: 'account', from: response)
        end

        # @api public
        # @return [Hash]
        # @param [Fixnum] id Account id
        def delete(id)
          http_client.delete("/admin/api/accounts/#{id}")
          true
        end


        # @api public
        # @return [Hash]
        # @param [Fixnum] id Account id
        # @param [Hash] attr Attributes to be updated
        # @options attr [String] org_name  Organization name
        def update(id, attr)
          body = {account: attr}
          response = http_client.put("/admin/api/accounts/#{id}", body: body)
          extract(entity: 'account', from: response)
        end

        # @api public
        # @param [Fixnum] id
        # @param [Fixnum] plan_id
        def set_plan(id, plan_id)
          body = {account: {plan_id: plan_id}}
          response = http_client.put("/admin/api/accounts/#{id}/change_plan", body: body)
          extract(entity: 'account', from: response)
        end

        def approve(id)
          response = http_client.put("/admin/api/accounts/#{id}/approve")
          extract(entity: 'account', from: response)
        end

        def reject(id)
          response = http_client.put("/admin/api/accounts/#{id}/reject")
          extract(entity: 'account', from: response)
        end

        def pending(id)
          response = http_client.put("/admin/api/accounts/#{id}/pending")
          extract(entity: 'account', from: response)
        end


        def users_list(account_id)
          response = http_client.get("/admin/api/accounts/#{account_id}/users")
          extract(collection: 'users', entity: 'user', from: response)
        end


        def user_create(account_id, attrs)
          body = {
              user: attrs
          }
          response = http_client.post("/admin/api/accounts/#{account_id}/users", body: body)
          extract(entity: 'user', from: response)
        end

        def user_read(account_id, user_id)
          response = http_client.get("/admin/api/accounts/#{account_id}/users/#{user_id}")
          extract(entity: 'user', from: response)
        end

        def user_delete(account_id, user_id)
          http_client.delete("/admin/api/accounts/#{account_id}/users/#{user_id}")
          true
        end

      end
    end
  end
end