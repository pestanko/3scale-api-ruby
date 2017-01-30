require 'securerandom'
require '3scale/api'

RSpec.describe 'Application plan API', type: :integration do
  let(:endpoint) { ENV.fetch('ENDPOINT') }
  let(:provider_key) { ENV.fetch('PROVIDER_KEY') }
  let(:service_id)   { ENV.fetch('SERVICE_ID').to_i }
  let(:name) { SecureRandom.uuid }
  let(:unit) {'click'}

  subject(:client) { ThreeScale::API.new(endpoint: endpoint, provider_key: provider_key) }

  subject(:metric) do
    client.create_metric(service_id, friendly_name: name, unit: unit)
  end

  before(:each) do
    @metric = client.create_metric(service_id, friendly_name: name, unit: 'click') # placeholder until we have direct access to DB
  end

  after(:each) do
    if @metric != nil
      begin
        client.delete_metric(service_id, @metric['id']) # placeholder until we have direct access to DB
      rescue ThreeScale::API::HttpClient::NotFoundError
      rescue ThreeScale::API::HttpClient::ForbiddenError
      end
    end
  end

  context '#metrics_crud' do
    it 'create metric' do
      expect(@metric).to include('friendly_name' => name)
    end

    it 'list metrics' do
      expect(client.list_metrics(service_id).length).to be >= 1
    end

    it 'read metric' do
      expect(client.read_metric(service_id, @metric['id'])).to include('friendly_name' => name)
    end

    it 'update metric' do
      expect(@metric).to include('friendly_name' => name, 'unit' => unit)

      newValue = 'updated value'
      expect(client.update_metric(service_id, @metric['id'], friendly_name: newValue, unit: newValue)
      ).to include('friendly_name' => newValue, 'unit' => newValue)
    end

    it 'delete metric' do
      client.delete_metric(service_id, @metric['id'])
      expect(client.list_metrics(service_id).any? { |metric| metric['id'] == @metric['id'] }).to be(false)
    end
  end


end