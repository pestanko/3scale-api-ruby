module ThreeScale
  module API
    module Managers
      class ServicePlans < DefaultManager

        # @api public
        # @return [Array<Hash>] List of services
        def list
          response = http_client.get('/admin/api/service_plans')
          extract(collection: 'plans', entity: 'plan', from: response)
        end

        # @api public
        # @param [Fixnum] service_id Service Id
        # @param [Fixnum] plan_id Service plan Id
        def set_default(service_id, plan_id)
          response = http_client.put("/admin/api/services/#{service_id}/service_plans/#{plan_id}/default")
          extract(entity: 'service', from: response)
        end

      end
    end
  end
end