# frozen_string_literal: true

require 'three_scale_api/clients/default'

require 'three_scale_api/resources/invoice_line_item'

module ThreeScaleApi
  module Clients
    # Metric resource manager wrapper for the metric entity received by REST API
    class InvoiceLineItemClient < DefaultClient

      def entity_name
        'line_item'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/line_items'
      end
    end
  end
end
