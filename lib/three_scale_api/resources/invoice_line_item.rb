# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/invoice_line_item'

module ThreeScaleApi
  module Resources
    # Invoice resource wrapper for the metric entity received by the REST API
    class InvoiceLineItem < DefaultResource

      # @api public
      # Construct the invoice line item resource
      #
      # @param [ThreeScaleApi::HttpClient] client Instance of http client
      # @param [ThreeScaleApi::Clients::InvoiceClient] manager Invoice line item manager
      # @param [Hash] entity Entity Hash from API client of the invoice line item
      def initialize(client, manager, entity)
        super(client, manager, entity)
      end
    end
  end
end
