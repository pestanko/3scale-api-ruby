# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/clients/invoice_line_item'

require 'three_scale_api/resources/invoice'

module ThreeScaleApi
  module Clients
    # Invoices resource manager wrapper for the metric entity received by REST API
    class InvoiceClient < DefaultClient
      def entity_name
        'invoice'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        '/api/invoices'
      end

      # @api public
      # Modifies the state of the Invoice.
      #
      # @param [Fixnum] id ID of the Invoice.
      # @param [String] state State of the Invoice to set.
      #     Values allowed (depend on the previous state): cancelled, failed, paid, unpaid, pending, finalized
      def set_state(id, state)
        log.info "Set invoice state [#{id}]: #{state}"
        response = rest.put("#{url}/#{id}/state", body: { state: state })
        log_result resource_instance(response)
      end

      # @api public
      # Charge an Invoice.
      #
      # @param [Fixnum] id ID of the Invoice.
      def charge(id)
        log.info "Charge the invoice [#{id}]"
        response = rest.post("#{url}/#{id}/charge", body: { id: id })
        log_result resource_instance(response)
      end

      # @api public
      # Triggers billing process for all developer accounts.
      # (Not available by default, contact support if you need this feature.)
      # @param [Date] date Overrides the current base date for the billing process.
      #     Format YYYY-MM-DD. Default: current date.
      def trigger_billing(date)
        log.info 'Trigger billing'
        response = rest.post("#{super.url}/billing_jobs", body: { date: date })
        log_result resource_instance(response)
      end
    end
  end
end
