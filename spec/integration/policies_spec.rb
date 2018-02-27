# frozen_string_literal: true

require_relative '../shared_tests_config'

RSpec.describe 'Policies API', type: :integration do
  include_context 'Shared initialization'

  before(:all) do
    @service = create_service
    @manager = @service.policies
  end

  after(:all) do
    clean_resource(@service)
  end

  context '#policies CRUD' do

    let(:policies) { @manager.list }

    let(:headers_config) do
      {
        "name":      'headers',
        "humanName": 'Headers policy',
        "version":   'builtin',
        "enabled":   true,
        "removable": true,
        "configuration":
                     {
                       "response":
                         [
                           {
                             "op":     'set',
                             "header": 'X-RESPONSE-CUSTOM-SET',
                             "value":  'Response set header',
                           },
                         ],
                       "request":
                         [
                           {
                             "op":     'set',
                             "header": 'X-REQUEST-CUSTOM-SET',
                             "value":  'Request set header',
                           },
                         ],
                     },
      }
    end

    let(:apicast_config) do
      {
        "name":          'apicast',
        "version":       'builtin',
        "configuration": {},
        "enabled":       true,
      }
    end

    let(:updated) do
      @manager.update([apicast_config, headers_config])
    end


    it 'should read policies' do
      expect(policies.length).to eq(1)
    end

    it 'should update policies' do
      expect(updated.length).to eq(2)
    end
  end
end
