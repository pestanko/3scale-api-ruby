# frozen_string_literal: true

require_relative '../shared_examples'

RSpec.describe 'Invoice Resource', type: :integration do
  include_context 'Shared initialization'

  let(:invoice_period) { '2011-05-01' }

  def create_res_instance(acc_id = nil)
    @manager.create(
      'account_id'  => acc_id,
      'period'      => '2011-05',
      'friendly_id' => '2011-05020100'
      )
  end

  before(:all) do
    @acc_resource = create_account
    @manager      = @client.invoices
    @resource     = create_res_instance(@acc_resource[:id])
  end

  after(:all) do
    @resource.set_state('cancelled')
    clean_resource(@acc_resource)
  end


  context 'Create' do
    it 'should create resource' do
      expect(@resource[:period]['begin']).to eq('2011-05-01')
    end
  end

  context 'List' do
    it 'should list resource' do
      expect(@manager.list.any? { |res| res[:period]['begin'] == invoice_period }).to be(true)
    end
  end

  context 'Read' do
    it 'should not call http_client get' do
      expect(@manager.http_client).not_to receive(:get)
      @manager.read(@resource['id'])
    end
  end
end
