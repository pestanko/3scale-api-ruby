# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/invoice_line_item'

module ThreeScaleApi
  module Resources
    # Invoice resource wrapper for the metric entity received by the REST API
    class Invoice < DefaultResource

      # @api public
      # Construct the invoice resource
      #
      # @param [ThreeScaleApi::HttpClient] client Instance of http client
      # @param [ThreeScaleApi::Clients::InvoiceClient] manager Invoices manager
      # @param [Hash] entity Entity Hash from API client of the invoice
      def initialize(client, manager, entity)
        super(client, manager, entity)
      end

      def line_items
        manager_instance(:InvoiceLineItem)
      end

      # @api public
      # Sets state of the account
      #
      # @param [String] state State of the Invoice to set.
      #     Values allowed (depend on the previous state): cancelled, failed, paid, unpaid, pending, finalized
      def set_state(state)
        @manager.set_state(@entity_id, state) if @manager.respond_to?(:set_state)
      end

      def charge
        @manager.charge(@entity_id) if @manager.respond_to?(:charge)
      end
    end
  end
end
