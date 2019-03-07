# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/clients/default'
require 'three_scale_api/resources/provider'

module ThreeScaleApi
  module Clients
    # Provider resource manager wrapper for the provider entity received by the REST API
    class ProviderClient < DefaultClient
      include DefaultUserClient

      def entity_name
        'user'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/users'
      end


      def create_token(id, params)
        log.info "Create new token for user [#{id}]: #{params}"
        response = rest.put("#{url}/#{id}/access_tokens", body: params)
        log_result resource_instance(response)
      end
    end
  end
end
