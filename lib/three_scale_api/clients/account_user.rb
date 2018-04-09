# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/account_user'

module ThreeScaleApi
  module Clients
    # Account user resource manager wrapper for account user entity received by REST API
    class AccountUserClient < DefaultClient
      include DefaultUserClient


      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/users'
      end
    end
  end
end
