# frozen_string_literal: true

require 'three_scale_api/tools'
require 'three_scale_api/logging_support'
require 'three_scale_api/resources/default'

module ThreeScaleApi
  # Main module containing implementation of the resources and it's managers
  module Clients
    # Client mixin
    class DefaultRestClient
      # @return [ThreeScaleApi::DefaultResource] Instance of the 3Scale resource
      attr_reader :resource

      # @api public
      # Creates instance of the Default resource manager
      #
      # @param [ThreeScaleApi::DefaultResource] resource Instance of the 3Scale resource
      def initialize(resource)
        @resource = resource
      end

      # @api public
      # Gets an instance of the default resource
      #
      # @return [ThreeScaleApi::ThreeScaleApi] 3Scale api instance
      def default_client
        resource.default_client
      end

      # @api public
      # Gets an instance of the Rest Http resource
      #
      # @return [ThreeScaleApi::HttpClient] Http resource instance
      def rest
        resource.rest
      end
    end

    # Default resource manager wrapper for default entity received by REST API
    # All other managers inherits from Default manager
    class DefaultClient < DefaultRestClient
      include LoggingSupport

      def entity_name
        nil
      end

      def collection_name
        "#{entity_name}s" if entity_name
      end

      # @api public
      # Base path for the REST call
      #
      # @return [String] Base URL for the REST call
      def url
        +'/admin/api'
      end

      # @api public
      # Access entity by it's ID or name
      #
      # @param [String,Fixnum] key Id or name of the entity
      # @return [DefaultResource] Requested entity
      def [](key)
        if key.is_a? Numeric
          read(key)
        else
          read_by_name(key)
        end
      end

      # @api public
      # Update entity
      #
      # @param [String,Fixnum] key id or name of the entity
      # @param [DefaultEntity] value Entity to be updated
      # @return [DefaultEntity] Updated entity
      def []=(key, value)
        id = if key.is_a? Numeric
               key
             else
               read_by_name(key)['id']
             end
        update(value, id: id)
      end

      # @api public
      # Creates entity
      #
      # @param [Hash] attributes Attributes for service to be created
      # @return [DefaultResource] Created resource
      def <<(attributes)
        create(attributes)
      end

      # Default method to list all the resources by manager
      #
      # @return [Array<DefaultResource>] The list of the Resources
      # @param [Hash] params optional arguments
      def list(params: {})
        log.debug("List #{resource_name}s [#{url}]")
        log_result _list(params: params)
      end

      # Default delete function
      def delete(id, params: {})
        log.info("Delete #{resource_name}: #{id} [#{url}/#{id}]")
        rest.delete("#{url}/#{id}", params: params)
        true
      end

      # @api public
      # Default read function
      #
      # @param [Fixnum] id Id of the entity
      # @return [DefaultResource] Instance of the default resource
      def fetch(id = nil)
        path = url
        path = "#{path}/#{id}" unless id.nil?
        log.debug("Fetched #{resource_name}: #{path}")
        response = rest.get(path)
        log_result resource_instance(response)
      end

      # @api public
      # Finds resource by it's system name
      #
      # @param [String] name System name
      # @return [DefaultResource] Resource instance
      def read_by_name(name)
        name = name.to_s
        find do |ent|
          [
            ent['system_name'],
            ent['name'],
            ent['org_name'],
            ent['friendly_name'],
            ent['username'],
            ent['pattern'],
          ].include?(name)
        end
      end

      # @api public
      # Finds resource by it's spec. attribute name
      #
      # @param [Hash] params Optional parameters
      # @param [Block] block Condition block
      # @return [DefaultResource] Resource instance
      def find(params: {}, &block)
        log.debug("Find #{resource_name}  [#{url}]")
        resources = _list(params: params)
        log_result resources.find(&block)
      end

      # @api public
      # Selects resources by it's spec. conditions
      #
      # @param [Hash] params Optional parameters
      # @param [Block] block System name
      # @return [Array<DefaultResource>] Array of Resources instance
      def select(params: {}, &block)
        log.debug("Select #{resource_name}")
        resources = _list(params: params)
        log_result resources.select(&block)
      end

      # @api public
      # Creates new resource
      #
      # @param [Hash] attributes Attributes of the created object
      # @return [DefaultResource] Created resource
      def create(attributes)
        log.info("Create [#{url}] #{resource_name}: #{attributes}")
        response = rest.post(url, body: attributes)
        log_result resource_instance(response)
      end

      # @api public
      # Updates existing resource
      #
      # @param [Hash, DefaultResource] attributes Attributes that will be updated
      # @return [DefaultResource] Updated resource
      def update(attributes, id: nil, method: :put)
        id   ||= attributes['id']
        path = url
        path = "#{path}/#{id}" unless id.nil?
        log.info("Update [#{path}]: #{attributes}")
        response = rest.method(method).call(path, body: attributes)
        log_result resource_instance(response)
      end

      # Internal list method method to list all the resources by manager
      #
      # @return [Array<DefaultResource>] The list of the Resources
      # @param [Hash] params optional arguments
      def _list(params: {})
        resource_list rest.get(url, params: params)
      end

      def resource_class
        Resources.const_get resource_name
      end

      # @api public
      # Returns resource without fetched entity
      #
      # @param [Fixnum] selector Entity ID
      def read(selector = nil)
        instance(selector: selector)
      end

      # Wrapper to create instance of the Resource
      # Requires to have @resource_instance initialized to correct Resource subtype
      #
      # @param [Hash] entity Entity received from REST call using API
      # @return [DefaultResource] Specific instance of the resource
      def instance(entity: nil, selector: nil, klass: nil)
        inst = {}
        klass ||= resource_class

        if klass.respond_to?(:new)
          inst = klass.new(self,
                           entity:    entity,
                           entity_id: selector)
        end

        instance_name = inst.class.name.split('::').last
        log.debug("[RES] #{instance_name}: #{entity}")
        inst
      end

      # Wrap result of the call to the instance
      #
      # @param [object] response Response from server
      def resource_instance(response)
        result = Tools.extract(entity: entity_name, from: response)
        instance(entity: result)
      end

      # Wrap result array of the call to the instance
      #
      # @param [object] response Response from server
      def resource_list(response)
        result = Tools.extract(collection: collection_name, entity: entity_name, from: response)
        result.map { |res| instance(entity: res) }
      end

      # Gets manager name for logging purposes
      #
      # @return [String] Manager name
      def manager_name
        self.class.name.split('::').last
      end

      # Gets resource name for specific manager
      #
      # @return [String] Manager name
      def resource_name
        manager           = manager_name.dup
        manager['Client'] = ''
        manager
      end

      # Logs result of the operation
      #
      # @param [DefaultEntity] result Result of the operation
      # @return [DefaultEntity] Returns the same entity
      def log_result(result)
        if result.is_a?(Array)
          log.info(" #{resource_name}s: #{result.length}")
          result.each_with_index { |res, index| log.info("\tItem #{index}: #{res}") }
        else
          log.debug(" --> Result: #{result}")
        end
        result
      end
    end

    # Default state resource manager wrapper for default entity received by REST API
    module DefaultStateClient
      # @api public
      # Sets account to spec. state
      #
      # @param [Fixnum] id Account ID
      # @param [String] state 'approve' or 'reject' or 'make_pending'
      def set_state(id, state = 'approve')
        log.info "Set state [#{id}]: #{state}"
        response = rest.put("#{url}/#{id}/#{state}")
        log_result resource_instance(response)
      end
    end

    # Default user resource manager wrapper for default entity received by REST API
    module DefaultUserClient
      include DefaultStateClient
      def entity_name
        'user'
      end

      # @api public
      # Suspends the user
      #
      # @param [Fixnum] id User ID
      def suspend(id)
        set_state(id, state: 'suspend')
      end

      # @api public
      # Resumes the user
      #
      # @param [Fixnum] id User ID
      def resume(id)
        set_state(id, state: 'unsuspend')
      end

      # @api public
      # Resumes the user
      #
      # @param [Fixnum] id User ID
      def activate(id)
        set_state(id, state: 'activate')
      end

      # @api public
      # Sets role as admin
      #
      # @param [Fixnum] id User ID
      def set_as_admin(id)
        set_state(id, state: 'admin')
      end

      # @api public
      # Sets role as member
      #
      # @param [Fixnum] id User ID
      def set_as_member(id)
        set_state(id, state: 'member')
      end
    end
  end
end
