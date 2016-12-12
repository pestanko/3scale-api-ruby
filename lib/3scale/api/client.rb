require '3scale/api/managers'

module ThreeScale
  module API
    class Client
      attr_reader :http_client

      # @param [ThreeScale::API::HttpClient] http_client

      def initialize(http_client)
        @http_client = http_client
      end

      ####################################
      #         Account plans            #
      ####################################

      # @api public
      # @return [Hash]
      def account_plan_list
        response = http_client.get('/admin/api/account_plans')
        extract(collection: 'plans', entity: 'plan', from: response)
      end

      # @api public
      # @param [String] name
      # @param [String] system_name
      # @return [Hash]
      def account_plan_create(name, system_name)
        body = {service: {name: name, system_name: system_name}}
        response = http_client.post('/admin/api/account_plans', body: body)
        extract(entity: 'plan', from: response)
      end

      # @api public
      # @param [Fixnum] id Id of the application plan
      # @return [Hash] Application plan hash
      def account_plan_show(id)
        response = http_client.get("/admin/api/account_plans/#{id}")
        extract(entity: 'plan', from: response)
      end

      # @api public
      # @param [Fixnum] id Id of account plan
      # @param [Object] attr Attributes that should be updated
      # @option attr [Hash] name Name of the plan
      def account_plan_update(id, attr)
        body = { plan: attr}
        response = http_client.put("/admin/api/account_plans/#{id}", body: body)
        extract(entity: 'plan', from: response)
      end

      # @api public
      # @param [Fixnum] id Id of the application plan
      # @return [Hash] Application plan hash
      def account_plan_delete(id)
        http_client.delete("/admin/api/account_plans/#{id}")
        true
      end

      # @api public
      # @param [Fixnum] id Application plan ID
      # @return [Hash]Application plan hash
      def account_plan_default(id)
        response = http_client.put("/admin/api/account_plans/#{id}/default")
        extract(entity: 'plan', from: response)
      end

      ####################################
      #              Accounts            #
      ####################################

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
      def signup(attributes = {}, name:, username:, **rest)
        body = { org_name: name,
                 username: username }.merge(attributes).merge(rest)
        response = http_client.post('/admin/api/signup', body: body)
        extract(entity: 'account', from: response)
      end

      # @api public
      # @return [Hash]
      def provider_account_show
        response = http_client.get('/admin/api/provider')
        extract(entity: 'account', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      def account_list
        response = http_client.get('/admin/api/accounts')
        extract(collection: 'accounts', entity: 'account', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] id Account id
      def account_show(id)
        response = http_client.get("/admin/api/accounts/#{id}")
        extract(entity: 'account', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] id Account id
      def account_delete(id)
        http_client.delete("/admin/api/accounts/#{id}")
        true
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] id Account id
      # @param [Hash] attr Attributes to be updated
      # @options attr [String] org_name  Organization name
      def account_update(id, attr)
        body = {account: attr}
        response = http_client.put("/admin/api/accounts/#{id}", body: body)
        extract(entity: 'account', from: response)
      end

      # @param [Fixnum] id Account Id
      # @param [Fixnum] plan_id Account plan Id
      def account_change_plan(id, plan_id)
        body = {account: {plan_id: plan_id}}
        response = http_client.put("/admin/api/accounts/#{id}/change_plan", body: body)
        extract(entity: 'account', from: response)
      end

      def account_approve(id)
        response = http_client.put("/admin/api/accounts/#{id}/approve")
        extract(entity: 'account', from: response)
      end

      def account_reject(id)
        response = http_client.put("/admin/api/accounts/#{id}/reject")
        extract(entity: 'account', from: response)
      end

      def account_pending(id)
        response = http_client.put("/admin/api/accounts/#{id}/pending")
        extract(entity: 'account', from: response)
      end

      ####################################
      #         Service plans            #
      ####################################

      # @api public
      # @return [Array<Hash>] List of services
      def service_plans_list
        response = http_client.get('/admin/api/service_plans')
        puts response
        extract(collection: 'plans', entity: 'service_plan', from: response)
      end

      # @api public
      # @param [Fixnum] service_id Service Id
      # @param [Fixnum] plan_id Service plan Id
      def service_plans_set_default(service_id, plan_id)
        response = http_client.put("/admin/api/services/#{service_id}/service_plans/#{plan_id}/default")
        extract(entity: 'plan', from: response)
      end

      ####################################
      #              Services            #
      ####################################

      # @api public
      # @return [Hash]
      # @param [Fixnum] id Service ID
      def show_service(id)
        response = http_client.get("/admin/api/services/#{id}")
        extract(entity: 'service', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      def list_services
        response = http_client.get('/admin/api/services')
        extract(collection: 'services', entity: 'service', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Hash] attr Service Attributes
      # @option attributes [String] :name Service Name
      def create_service(attr)
        response = http_client.post('/admin/api/services', body: { service: attr })
        extract(entity: 'service', from: response)
      end

      ####################################
      #              Proxy               #
      ####################################

      # @api public
      # @return [Hash]
      # @param [Fixnum] service_id Service ID
      def show_proxy(service_id)
        response = http_client.get("/admin/api/services/#{service_id}/proxy")
        extract(entity: 'proxy', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] service_id Service ID
      def update_proxy(service_id, attributes)
        response = http_client.patch("/admin/api/services/#{service_id}/proxy",
                                     body: { proxy: attributes })
        extract(entity: 'proxy', from: response)
      end

      ####################################
      #         Applications             #
      ####################################

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      def list_applications(service_id: nil)
        params = service_id ? { service_id: service_id } : nil
        response = http_client.get('/admin/api/applications', params: params)
        extract(collection: 'applications', entity: 'application', from: response)
      end


      def list_applications_for_account(account_id)
        response = http_client.get("/admin/api/accounts/#{account_id}/applications.xml")
        extract(collection: 'applications', entity: 'application', from: response)
      end


      # @api public
      # @return [Hash]
      # @param [Fixnum] id Application ID
      def show_application(id)
        find_application(id: id)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] id Application ID
      # @param [String] user_key Application User Key
      # @param [String] application_id Application App ID
      def find_application(id: nil, user_key: nil, application_id: nil)
        params = { application_id: id, user_key: user_key, app_id: application_id }.reject { |_, value| value.nil? }
        response = http_client.get('/admin/api/applications/find', params: params)
        extract(entity: 'application', from: response)
      end

      # @api public
      # @return [Hash] an Application
      # @param [Fixnum] plan_id Application Plan ID
      # @param [Hash] attributes Application Attributes
      # @option attributes [String] :name Application Name
      # @option attributes [String] :description Application Description
      # @option attributes [String] :user_key Application User Key
      # @option attributes [String] :application_id Application App ID
      # @option attributes [String] :application_key Application App Key(s)
      def create_application(account_id, attributes = {}, plan_id:, **rest)
        body = { plan_id: plan_id }.merge(attributes).merge(rest)
        response = http_client.post("/admin/api/accounts/#{account_id}/applications", body: body)
        extract(entity: 'application', from: response)
      end

      ####################################
      #          Application plans       #
      ####################################

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      def list_service_application_plans(service_id)
        response = http_client.get("/admin/api/services/#{service_id}/application_plans")
        extract(collection: 'plans', entity: 'application_plan', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] service_id Service ID
      # @param [Hash] attributes Metric Attributes
      # @option attributes [String] :name Application Plan Name
      def create_application_plan(service_id, attributes)
        body = {application_plan: attributes}
        response = http_client.post("/admin/api/services/#{service_id}/application_plans",
                                    body: body)
        extract(entity: 'application_plan', from: response)
      end

      # @api public
      # @param [Fixnum] service_id
      # @return [Boolean]
      def delete_application_plan(service_id, id)
        http_client.delete("/admin/api/services/#{service_id}/application_plans/#{id}")
        true
      end

      def application_plan_default(service_id, id)
        response = http_client.put("/admin/api/services/#{service_id}/application_plans/#{id}/default")
        extract(entity: 'application_plan', from: response)
      end

      # @api public
      # @return [Hash] a Plan
      # @param [Fixnum] account_id Account ID
      # @param [Fixnum] application_id Application ID
      def customize_application_plan(account_id, application_id)
        response = http_client.put("/admin/api/accounts/#{account_id}/applications/#{application_id}/customize_plan")
        extract(entity: 'application_plan', from: response)
      end

      ####################################
      #             Metrics              #
      ####################################

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      def list_metrics(service_id)
        response = http_client.get("/admin/api/services/#{service_id}/metrics")
        extract(collection: 'metrics', entity: 'metric', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] service_id Service ID
      # @param [Hash] attributes Metric Attributes
      # @option attributes [String] :name Metric Name
      def create_metric(service_id, attributes)
        response = http_client.post("/admin/api/services/#{service_id}/metrics", body: { metric: attributes })
        extract(entity: 'metric', from: response)
      end


      ####################################
      #             Mappings             #
      ####################################

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      def list_mapping_rules(service_id)
        response = http_client.get("/admin/api/services/#{service_id}/proxy/mapping_rules")
        extract(entity: 'mapping_rule', collection: 'mapping_rules', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      # @param [Fixnum] id Mapping Rule ID
      def show_mapping_rule(service_id, id)
        response = http_client.get("/admin/api/services/#{service_id}/proxy/mapping_rules/#{id}")
        extract(entity: 'mapping_rule', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      # @param [Hash] attributes Mapping Rule Attributes
      # @option attributes [String] :http_method HTTP Method
      # @option attributes [String] :pattern Pattern
      # @option attributes [Fixnum] :delta Increase the metric by delta.
      # @option attributes [Fixnum] :metric_id Metric ID
      def create_mapping_rule(service_id, attributes)
        response = http_client.post("/admin/api/services/#{service_id}/proxy/mapping_rules",
                                    body: { mapping_rule: attributes })
        extract(entity: 'mapping_rule', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      # @param [Fixnum] id Mapping Rule ID
      def delete_mapping_rule(service_id, id)
        http_client.delete("/admin/api/services/#{service_id}/proxy/mapping_rules/#{id}")
        true
      end

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      # @param [Fixnum] id Mapping Rule ID
      # @param [Hash] attributes Mapping Rule Attributes
      # @option attributes [String] :http_method HTTP Method
      # @option attributes [String] :pattern Pattern
      # @option attributes [Fixnum] :delta Increase the metric by delta.
      # @option attributes [Fixnum] :metric_id Metric ID
      def update_mapping_rule(service_id, id, attributes)
        response = http_client.patch("/admin/api/services/#{service_id}/mapping_rules/#{id}",
                                     body: { mapping_rule: attributes })
        extract(entity: 'mapping_rule', from: response)
      end


      ####################################
      #             Methods              #
      ####################################

      # @api public
      # @return [Hash]
      # @param [Fixnum] service_id Service ID
      # @param [Fixnum] metric_id Metric ID
      # @param [Hash] attributes Metric Attributes
      # @option attributes [String] :name Method Name
      def create_method(service_id, metric_id, attributes)
        response = http_client.post("/admin/api/services/#{service_id}/metrics/#{metric_id}/methods",
                                    body: { metric: attributes })
        extract(entity: 'method', from: response)
      end

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] service_id Service ID
      # @param [Fixnum] metric_id Metric ID
      def list_methods(service_id, metric_id)
        response = http_client.get("/admin/api/services/#{service_id}/metrics/#{metric_id}/methods")
        extract(collection: 'methods', entity: 'method', from: response)
      end

      ####################################
      #    Application plan limits       #
      ####################################

      # @api public
      # @return [Array<Hash>]
      # @param [Fixnum] application_plan_id Application Plan ID
      def list_application_plan_limits(application_plan_id)
        response = http_client.get("/admin/api/application_plans/#{application_plan_id}/limits")
        extract(collection: 'limits', entity: 'limit', from: response)
      end

      # @api public
      # @return [Hash]
      # @param [Fixnum] application_plan_id Application Plan ID
      # @param [Hash] attributes Metric Attributes
      # @param [Fixnum] metric_id Metric ID
      # @option attributes [String] :period Usage Limit period
      # @option attributes [String] :value Usage Limit value
      def create_application_plan_limit(application_plan_id, metric_id, attributes)
        response = http_client.post("/admin/api/application_plans/#{application_plan_id}/metrics/#{metric_id}/limits",
                                    body: { usage_limit: attributes })
        extract(entity: 'limit', from: response)
      end

      # @param [Fixnum] application_plan_id Application Plan ID
      # @param [Fixnum] metric_id Metric ID
      # @param [Fixnum] limit_id Usage Limit ID
      def delete_application_plan_limit(application_plan_id, metric_id, limit_id)
        http_client.delete("/admin/api/application_plans/#{application_plan_id}/metrics/#{metric_id}/limits/#{limit_id}")
        true
      end

      protected

      def extract(collection: nil, entity:, from:)
        from = from.fetch(collection) if collection

        case from
        when Array then from.map { |e| e.fetch(entity) }
        when Hash then from.fetch(entity) { from }
        when nil then nil # raise exception?
        else
          raise "unknown #{from}"
        end
      end
    end
  end
end
