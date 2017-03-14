require '3scale/api/managers'
require '3scale/api'
require 'webmock/rspec'

RSpec.describe ThreeScale::API::Managers::ActiveDocs do
  let(:http_client) { double(ThreeScale::API::HttpClient) }

  it { is_expected.to be }

  subject(:client) { described_class.new(http_client) }


  context '#list' do
    it do
      expect(http_client).to receive(:get).with('/admin/api/active_docs').and_return('active_docs' => [])
      expect(client.list).to eq([])
    end
  end

  context '#create' do
    it do
      expect(http_client).to receive(:post)
                                 .with('/admin/api/active_docs', body: { })
                                 .and_return('active_doc' => {})
      expect(client.create(name, {})).to eq({})
    end
  end

  context '#update' do
    it do
      expect(http_client).to receive(:put)
                                 .with('/admin/api/active_docs/42', body: { })
                                 .and_return('active_doc' => {})
      expect(client.update(42, {})).to eq({})
    end
  end

end
