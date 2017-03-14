require 'securerandom'
require '3scale/api'


RSpec.describe 'Active Docs API', type: :integration do
  let(:endpoint) { ENV.fetch('ENDPOINT') }
  let(:provider_key) { ENV.fetch('PROVIDER_KEY') }
  let(:name) { SecureRandom.uuid }
  let(:body) { 'Swagger Sample App' }
  let(:rnd_num) { SecureRandom.random_number(1000000000) * 1.0 }
  let(:client) { ThreeScale::API.new(endpoint: endpoint, provider_key: provider_key) }

  before(:each) do
    @active_doc = client.active_docs.create(name, body) # placeholder until we have direct access to DB
  end

  after(:each) do

    if @active_doc != nil
      begin
        client.active_docs.delete(@active_doc['id']) # placeholder until we have direct access to DB
      rescue ThreeScale::API::HttpClient::NotFoundError
      rescue ThreeScale::API::HttpClient::ForbiddenError

      end
    end

  end

  context '#active_docs_crud' do
    it 'creates an active doc' do
      expect(@active_doc).to include('name' => name)
      expect(@active_doc).to include('body' => body)
      expect(@active_doc).to include('published' => true)
    end

    it 'list an active doc' do
      expect(client.active_docs.list.any? { |serv| serv['name'] == @active_doc['name'] }).to be_truthy
    end


    it 'delete active doc' do
      client.active_docs.delete(@active_doc['id'])
      expect(client.active_docs.list.any? { |doc| doc['name'] == @active_doc['name'] }).to be_falsey
      @active_doc = nil
    end

    it 'updates active doc' do
      client.active_docs.update(@active_doc['id'], { published: false })
      doc = client.active_docs.list.find { |doc| doc['name'] == @active_doc['name'] }
      expect(doc).to be_truthy
      expect(doc).to include('published' => false)
      expect(doc).to include('name' => name)
      expect(doc).to include('body' => body)
    end

  end
end
