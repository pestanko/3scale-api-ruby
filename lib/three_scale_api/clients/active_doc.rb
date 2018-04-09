# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/active_doc'

module ThreeScaleApi
  module Clients
    # Active doc resource manager wrapper for the active doc entity received by the REST API
    class ActiveDocClient < DefaultClient
      def entity_name
        'api_doc'
      end

      # @api public
      # Fetches the active docs from the admin portal
      #
      # @param [Fixnum] id Entity id
      # @return [ThreeScaleApi::ActiveDocs]
      def fetch(id)
        log.info("Fetch #{resource_name}: #{id}")
        res = _list.find { |doc| doc['id'] == id }
        log_result res
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/active_docs'
      end
    end
  end
end
