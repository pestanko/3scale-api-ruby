# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/account'
require 'three_scale_api/clients/account_user'
require 'three_scale_api/clients/application'

module ThreeScaleApi
  module Clients
    # Accounts resource manager wrapper for default entity received by REST API
    class AccountClient < DefaultClient
      include DefaultStateClient

      def entity_name
        'account'
      end


      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/accounts'
      end

      # @api public
      # Creates developer account (Same way as used in Developer portal)
      # Will also create default user with username
      #
      # @param [Hash] attributes Attributes
      # @option attributes [String] :email User Email
      # @option attributes [String] :org_name Account name
      # @option attributes [String] :username User name
      # @option attributes [String] :password User Password
      # @option attributes [String] :account_plan_id Account Plan ID
      # @option attributes [String] :service_plan_id Service Plan ID
      # @option attributes [String] :application_plan_id Application Plan ID
      def sign_up(attributes)
        log.info("Sign UP: #{attributes}")
        response = rest.post('/admin/api/signup', body: attributes)
        log_result resource_instance(response)
      end

      # @api public
      # Creates developer
      #
      # Attributes same as for sign_up
      def create(attributes)
        sign_up(attributes)
      end

      # @api public
      # Sets default plan for dev. account
      #
      # @param [Fixnum] id Account ID
      # @param [Fixnum] plan_id Plan id
      def set_plan(id, plan_id)
        log.info("Set #{resource_name}  default (id: #{id}) ")
        body     = { plan_id: plan_id }
        response = rest.put("#{url}/#{id}/change_plan", body: body)
        log_result resource_instance(response)
      end

      # @api public
      # Gets invoice list for account
      #
      # @param [Fixnum] id Account id
      # @param [Hash] params Params
      def invoice_list(id, params)
        log.info("Get invoice list for account (id: #{id})")
        params[:account_id] ||= id
        response =  rest.get("/api/accounts/#{id}/invoices", params: params)
        log_result(response)
      end

      # @api public
      # Sends message to account
      #
      # @param [Fixnum] id Account ID
      # @param [Fixnum] body Message body
      def send_message(id, body)
        log.info("Sending message to (#{id}): #{body}")
        response = rest.post("#{url}/#{id}/messages", body: { body: body })
        log_result response
      end

      # @api public
      # Approves account
      #
      # @param [Fixnum] id Account ID
      def approve(id)
        set_state(id, 'approve')
      end

      # @api public
      # Rejects account
      #
      # @param [Fixnum] id Account ID
      def reject(id)
        set_state(id, 'reject')
      end

      # @api public
      # Set pending
      #
      # @param [Fixnum] id Account ID
      def pending(id)
        set_state(id, 'make_pending')
      end
    end
  end
end
