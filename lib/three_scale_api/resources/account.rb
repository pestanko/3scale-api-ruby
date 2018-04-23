# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/account_user'
require 'three_scale_api/clients/application'
require 'three_scale_api/clients/account_credit_card'

module ThreeScaleApi
  module Resources
    # Account Resource
    class Account < DefaultResource
      include DefaultStateResource

      # @api public
      # Sets plan for account
      #
      # @param [Fixnum] plan_id Plan ID
      def set_plan(plan_id)
        client.set_plan(entity, plan_id) if client.respond_to?(:set_plan)
      end

      # @api public
      # Approves account
      def approve
        set_state('approve')
      end

      # @api public
      # Reject account
      def reject
        set_state('reject')
      end

      # @api public
      # Set pending for account
      def pending
        set_state('pending')
      end

      # @api public
      # Gets Account Users Manager
      #
      # @return [AccountUsersManager] Account Users Manager
      def users
        Clients::AccountUserClient.new(self)
      end

      # @api public
      # Gets  Application client
      #
      # @return [Clients::ApplicationClient] Account Users client
      def applications
        Clients::ApplicationClient.new(self)
      end

      # @api public
      # Gets Credit card client
      #
      # @return [Clients::AccountCreditCardClient] Credit Card client
      def credit_card
        Clients::AccountCreditCardClient.new(self)
      end

      def send_message(body)
        client.send_message(entity_id, body)
      end
    end
  end
end
