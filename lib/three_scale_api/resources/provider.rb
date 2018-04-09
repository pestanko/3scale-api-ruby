# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/resources/default'

module ThreeScaleApi
  module Resources
    # Provider resource wrapper for the provider entity received by REST API
    class Provider < DefaultResource
      include DefaultUserResource
    end
  end
end
