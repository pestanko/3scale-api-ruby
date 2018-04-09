# frozen_string_literal: true

require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Account user resource wrapper for account user received by REST API
    class AccountUser < DefaultResource
      include DefaultUserResource

      def account
        client.parent
      end
    end
  end
end
