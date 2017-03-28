require 'securerandom'
require '3scale/api'


RSpec.describe 'Service API', type: :integration do
  let(:endpoint) { ENV.fetch('ENDPOINT') }
  let(:provider_key) { ENV.fetch('PROVIDER_KEY') }
  let(:name) { SecureRandom.uuid }
  let(:rnd_num) { SecureRandom.random_number(1000000000) * 1.0 }
  let(:client) { ThreeScale::API.new(endpoint: endpoint, provider_key: provider_key) }
  let!(:service) { client.services.create({name: name, system_name: name}) }

  after(:each) do
    begin
      client.services.delete(service['id'])
    rescue ThreeScale::API::HttpClient::NotFoundError
    end
  end

  context '#service_crud' do
    it 'creates a service' do
      expect(service).to include('name' => name)
    end

    it 'list an services' do
      expect(client.services.list.any? { |serv| serv['name'] == service['name'] }).to be(true)
    end

    it 'read a service' do
      expect(client.services.read(service['id'])).to include('name' => service['name'])
    end

    it 'delete service' do
      client.services.delete(service['id'])
      expect(client.services.list.any? { |serv| serv['name'] == service['name'] }).to be(false)
    end

    it 'update service' do
      expect(client.services.update(service['id'], name: 'testName')).to include('name' => 'testName')
    end
  end
end
