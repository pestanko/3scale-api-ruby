# frozen_string_literal: true

require_relative '../shared_examples'

RSpec.describe 'Invoice Line item Resource', type: :integration do
  include_context 'Shared initialization'

  let(:invoice_period) { '2011-05-01' }

  def create_res_instance(name = nil)
    @manager.create(name: name, quantity: 1, cost: 1, description: @name)
  end

  before(:all) do
    @acc_resource = create_account
    @invoice      = @client.invoices.create(account_id: @acc_resource[:id])
    @manager      = @invoice.line_items
    @resource     = create_res_instance(@name)
  end

  after(:all) do
    clean_resource(@resource)
    @invoice.set_state('cancelled')
    clean_resource(@acc_resource)
  end

  context 'Create' do
    it 'should create resource' do
      expect(@resource[:name]).to eq(@name)
    end
  end

  context 'List' do
    it 'should list resource' do
      expect(@manager.list.any? { |res| res[:name] == @name }).to be(true)
    end
  end
end
