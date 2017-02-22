module ThreeScale
  module API
    module Managers
      class Proxy < DefaultManager
        # @api public
        # @return [Hash]
        # @param [Fixnum] service_id Service ID
        def read(service_id)
          response = http_client.get("/admin/api/services/#{service_id}/proxy")
          extract(entity: 'proxy', from: response)
        end

        # @api public
        # @return [Hash]
        # @param [Fixnum] service_id Service ID
        def update(service_id, attributes)
          response = http_client.patch("/admin/api/services/#{service_id}/proxy",
                                       body: attributes)
          extract(entity: 'proxy', from: response)
        end

        # @api public
        # Promotes a Proxy Config from one environment to another environment.
        # @return [Hash]
        # @param [Fixnum] service_id Service id
        # @param [String] from_env Source environment
        # @param [Fixnum] config_id Configuration id
        # @param [String] to_env Target environment
        def promote(service_id, from_env, config_id, to_env)
          response = http_client.post("/admin/api/services/#{service_id}/proxy/configs/#{from_env}/#{config_id}/promote", params: {to: to_env})
          extract(entity: 'proxy_config', from: response)
        end

        # @api public
        # Returns the Proxy Configs of a Service
        # @return [Hash]
        # @param [Fixnum] service_id Service id
        # @param [String] env Gateway environment. Must be 'sandbox' or 'production'
        def config_list(service_id, env)
          response = http_client.get("/admin/api/services/#{service_id}/proxy/configs/#{env}")
          extract(collection: 'proxy_configs', entity: 'proxy_config', from: response)
        end

        # @api public
        # Returns the latest Proxy Config.
        # @return [Hash]
        # @param [Fixnum] service_id Service id
        # @param [String] env Gateway environment. Must be 'sandbox' or 'production'
        def config_latest(service_id, env)
          response = http_client.get("/admin/api/services/#{service_id}/proxy/configs/#{env}/latest")
          extract(entity: 'proxy_config', from: response)
        end

        # @api public
        # Returns a Proxy Config by ID
        # @return [Hash]
        # @param [Fixnum] service_id Service id
        # @param [String] env Gateway environment. Must be 'sandbox' or 'production'
        # @param [Fixnum] config_id Proxy config id
        def config_read(service_id, env, config_id)
          response = http_client.get("/admin/api/services/#{service_id}/proxy/configs/#{env}/#{config_id}")
          extract(entity: 'proxy_config', from: response)
        end
      end
    end
  end
end