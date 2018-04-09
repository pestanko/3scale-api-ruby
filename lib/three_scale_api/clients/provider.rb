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

      # @api public
      # Sets role as admin
      #
      # @param [Fixnum] id User ID
      def set_as_admin(id)
        set_state(id, state: 'admin')
      end

      # @api public
      # Sets role as member
      #
      # @param [Fixnum] id User ID
      def set_as_member(id)
        set_state(id, state: 'member')
      end

    end
  end
end
