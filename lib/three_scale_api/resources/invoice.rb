# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/invoice_line_item'

module ThreeScaleApi
  module Resources
    # Invoice resource wrapper for the metric entity received by the REST API
    class Invoice < DefaultResource
      def line_items
        Clients::InvoiceLineItemClient.new(self)
      end

      # @api public
      # Sets state of the account
      #
      # @param [String] state State of the Invoice to set.
      #     Values allowed (depend on the previous state): cancelled, failed, paid, unpaid, pending, finalized
      def set_state(state)
        client.set_state(entity_id, state) if client.respond_to?(:set_state)
      end

      def charge
        client.charge(entity_id) if client.respond_to?(:charge)
      end
    end
  end
end
