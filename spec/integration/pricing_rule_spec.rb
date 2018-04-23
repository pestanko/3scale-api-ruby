# frozen_string_literal: true

require_relative '../shared_tests_config'

RSpec.describe 'Pricing rule resource', type: :integration do
  include_context 'Shared initialization'

  before(:all) do
    @service  = create_service
    @unit     = 'click'
    @metric   = @service.metrics.create(friendly_name: @name, unit: @unit)
    @app_plan = @service.application_plans.create(name: @name, system_name: @name)
    @manager  = @app_plan.pricing_rules(@metric)
    @resource = @manager.create(min: 1, max: 100, cost_per_unit: 0.01)
  end

  after(:all) do
    clean_resource @app_plan
    clean_resource @metric
    clean_resource(@service)
  end

  context '#pricing_rule CRUD' do
    it 'should create pricing_rule' do
      expect(@resource).to res_include('min' => 1)
      expect(@resource).to res_include('max' => 100)
    end

    it 'should list pricing_rule' do
      expect(@manager.list.length).to be >= 1
    end
  end
end
