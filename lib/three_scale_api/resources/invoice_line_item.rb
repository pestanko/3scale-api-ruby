# frozen_string_literal: true

require 'three_scale_api/resources/default'
require 'three_scale_api/clients/invoice_line_item'

module ThreeScaleApi
  module Resources
    # Invoice resource wrapper for the metric entity received by the REST API
    class InvoiceLineItem < DefaultResource
      def invoice
        client.resource
      end
    end
  end
end
