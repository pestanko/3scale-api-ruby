# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/account_credit_card'

module ThreeScaleApi
  module Clients
    # Accounts resource manager wrapper for default entity received by REST API
    class AccountCreditCardClient < DefaultClient
      def url
        resource.url + '/credit_card'
      end

      # @api public
      # Associates credit card tokens and billing address to an account.
      # This operation is only required if you use your own credit card capture method.
      # These tokens are the ones required by Authorize.net, ogone, braintree,
      # payment express and merchant e solutions
      #
      # @param [Hash] attributes Attributes provided to set credit card
      # @option attributes [String] credit_card_token
      #   Token used by the payment gateway to identify the buyer -- shopper reference
      #   (Adyen), customer profile ID (Authorize.net),
      #   customer ID (Braintree and Stripe),
      #   customer alias (Ogone-Ingenico).
      #   Some payment gateways may store more than one card under the same
      #   buyer reference and/or require an additional identifier for recurring payment.
      #   If you are using Braintree, there is no need for additional identifier --
      #   the first credit card available will always be charged.
      #   For Adyen and Authorize.net, see
      #   `credit_card_authorize_net_payment_profile_token`.
      # @option attributes [String] credit_card_authorize_net_payment_profile_token
      #   Additional reference provided by the payment gateway to identify a specific card
      #   under the same buyer reference.
      #   For Authorize.net, you MUST fill with the 'Payment profile token'.
      #   For Adyen, use the `recurringDetailReference`
      #   (provided within the response for their `listRecurringDetails` API method),
      #   or leave it empty for always charging the LATEST card in their list.
      #   Not used for other payment gateways.
      # @option attributes [String] credit_card_expiration_year
      #     Year of expiration of credit card. Two digit number
      # @option attributes [String] credit_card_expiration_month
      #     Month of expiration of credit card. Two digit number
      # @option attributes [String] billing_address_name
      #     Name of the person/company to bill
      # @option attributes [String] billing_address_address
      #     Address associated to the credit card
      # @option attributes [String] billing_address_city
      #     Billing address city
      # @option attributes [String] billing_address_country
      #     Billing address country
      # @option attributes [String] billing_address_state
      #     Billing address state
      # @option attributes [String] billing_address_phone
      #     Billing address phone
      # @option attributes [String] billing_address_zip
      #     Billing address ZIP Code
      # @option attributes [String] credit_card_partial_number
      #     Last four digits on the credit card
      def update(attributes)
        path = url
        log.info("Setting credit card [#{path}]: #{attributes}")
        response = rest.put(path, body: attributes)
        log_result response
      end

      def create(attributes)
        update(attributes)
      end
    end
  end
end