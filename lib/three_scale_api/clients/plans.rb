# frozen_string_literal: true

require 'three_scale_api/clients/default'
require 'three_scale_api/resources/plans'

module ThreeScaleApi
  module Clients
    # Default plan resource manager wrapper
    module DefaultPlanClient

      def collection_name
        'plans'
      end

      # @api public
      # Lists all plans
      #
      # @return [Array<DefaultPlan>] List of DefaultPlans
      def list_all(path = nil)
        log.info("List all #{resource_name}s")
        response = rest.get(path)
        log_result resource_list(response)
      end

      # @api public
      # Sets global default plan
      #
      # @param [Fixnum] id Plan ID
      # @return [DefaultPlanResource] DefaultPlan plan instance
      def set_default(id)
        log.debug("Set default #{resource_name}: #{id}")
        response = rest.put("#{url}/#{id}/default")
        log_result resource_instance(response)
      end

      # @api public
      # Gets global default plan
      #
      # @return [DefaultPlanResource] Default plan plan instance
      def get_default
        log.info("Get default #{resource_name}:")
        result = nil
        _list.each do |plan|
          result = plan if plan['default']
        end
        log_result result
      end
    end

    # Application plan resource manager wrapper for an application plan entity
    # received by the REST API
    class ApplicationPlanClient < DefaultClient
      include DefaultPlanClient

      def entity_name
        'application_plan'
      end

      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/application_plans'
      end

      # @api public
      # Lists all application plans
      #
      # @return [Array<ServicePlan>] List of Application plans
      def list_all
        super('/admin/api/application_plans')
      end
    end

    # Account plan resource manager wrapper for account plan entity received by REST API
    class AccountPlanClient < DefaultClient
      include DefaultPlanClient

      def entity_name
        'account_plan'
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/account_plans'
      end

      # @api public
      # Lists all account plans
      #
      # @return [Array<ServicePlan>] List of AccountPlans
      def list_all
        super(url)
      end
    end

    # Service plan resource manager wrapper for the service plan entity received by the REST API
    class ServicePlanClient < DefaultClient
      include DefaultPlanClient

      def entity_name
        'service_plan'
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        resource.url + '/service_plans'
      end

      # @api public
      # Lists all service plans
      #
      # @return [Array<ServicePlan>] List of ServicePlans
      def list_all
        super('/admin/api/service_plans')
      end
    end
  end
end
