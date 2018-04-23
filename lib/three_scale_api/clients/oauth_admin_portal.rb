# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/oauth_admin_portal'

module ThreeScaleApi
  module Clients
    # WebHook resource manager wrapper for the WebHook entity received by the REST API
    class OAuthAdminPortalClient < DefaultClient
      def entity_name
        'authentication_provider'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/account/authentication_providers'
      end

      # @api public
      # Updates an authentication provider for the admin portal.
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
      # Creates an authentication provider for the admin portal.
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
