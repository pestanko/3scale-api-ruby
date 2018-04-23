# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/oauth_dev_portal'

module ThreeScaleApi
  module Clients
    # WebHook resource manager wrapper for the WebHook entity received by the REST API
    class OAuthDevPortalClient < DefaultClient
      def entity_name
        'authentication_provider'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/authentication_providers'
      end

      # @api public
      # Updates an authentication provider for the developer portal.
      #
      # @param [Hash] attributes Attributes that will be updated
      # @option attributes [String] client_id
      #     Client ID of the authentication provider.
      # @option attributes [String] client_secret
      #     Client Secret of the authentication provider.
      # @option attributes [String] site
      #     Site o Realm of the authentication provider.
      # @option attributes [Boolean] skip_ssl_certificate_verification
      #       Skip SSL certificate verification. False by default.
      # @option attributes [Boolean] published
      #     Published authentication provider. False by default
      def update(attributes)
        super(attributes, method: :put)
      end

      # @api public
      # Creates an authentication provider for the developer portal.
      #
      # @param [Hash] attributes Attributes that will be updated
      # @option attributes [String] kind
      #     Kind of the authentication provider. (rhsso)
      # @option attributes [String] name
      #     Name of the authentication provider.
      # @option attributes [String] system_name
      #     System Name of the authentication provider.
      # @option attributes [String] client_id
      #     Client ID of the authentication provider.
      # @option attributes [String] client_secret
      #     Client Secret of the authentication provider.
      # @option attributes [String] site
      #     Site o Realm of the authentication provider.
      # @option attributes [String] token_url
      #     Token URL of the authentication provider.
      # @option attributes [String] user_info_url
      #     User info URL of the authentication provider.
      # @option attributes [String] authorize_url
      #     Authorize URL of the authentication provider.
      # @option attributes [String] identifier_key
      #     Identifier key. 'id' by default.
      # @option attributes [String] username_key
      #     Username key. 'login' by default.
      # @option attributes [String] trust_email
      #     Trust emails automatically. False by default
      # @option attributes [String] branding_state_event
      #     Branding state event of the authentication provider. Only available for Github.
      #     It can be either 'brand_as_threescale' (the default one) or 'custom_brand'
      # @option attributes [String] automatically_approve_accounts
      #     Automatically approve accounts. False by default.
      # @option attributes [Boolean] skip_ssl_certificate_verification
      #       Skip SSL certificate verification. False by default.
      # @option attributes [Boolean] published
      #     Published authentication provider. False by default
      def create(attributes)
        super(attributes)
      end
    end
  end
end
