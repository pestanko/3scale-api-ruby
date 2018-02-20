# frozen_string_literal: true

require 'three_scale_api/clients/default'

require 'three_scale_api/resources/invoice_line_item'

module ThreeScaleApi
  module Clients
    # Metric resource manager wrapper for the metric entity received by REST API
    class InvoiceLineItemClient < DefaultClient
      attr_accessor :invoice

      # @api public
      # Creates instance of the Proxy resource manager
      #
      # @param [ThreeScaleQE::TestClient] http_client Instance of http client
      def initialize(http_client, invoice)
        super(http_client, entity_name: 'line_item')
        @invoice = invoice
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def base_path
        "/api/invoices/#{invoice[:id]}/line_items"
      end
    end
  end
end
