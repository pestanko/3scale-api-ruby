require '3scale/api/managers'
require '3scale/api'
require 'webmock/rspec'

RSpec.describe ThreeScale::API::Managers::Proxy do
  let(:http_client) { double(ThreeScale::API::HttpClient) }

  it { is_expected.to be }

  subject(:client) { described_class.new(http_client) }

  context '#show' do
    it do
      expect(http_client).to receive(:get).with('/admin/api/services/42/proxy').and_return('proxy' => {})
      expect(client.read(42)).to eq({})
    end
  end

  context '#update' do
    it do
      expect(http_client).to receive(:patch)
                                 .with('/admin/api/services/42/proxy',
                                       body: { })
                                 .and_return('proxy' => {})
      expect(client.update(42, {})).to eq({})
    end
  end

  context '#promote' do
    it do
      expect(http_client).to receive(:post)
          .with('/admin/api/services/42/proxy/configs/sandbox/5/promote',
          params: { to: 'production'}, body: {})
          .and_return('proxy_config' => {})
      expect(client.promote(42, 'sandbox', 5, 'production')).to eq({})
    end
  end

  context '#config_list' do
    it do
      expect(http_client).to receive(:get)
                               .with('/admin/api/services/42/proxy/configs/sandbox')
                               .and_return('proxy_configs' => [])
      expect(client.config_list(42, 'sandbox')).to eq([])
    end
  end

  context '#config_latest' do
    it do
      expect(http_client).to receive(:get)
                                 .with('/admin/api/services/42/proxy/configs/sandbox/latest')
                                 .and_return('proxy_config' => {})
      expect(client.config_latest(42, 'sandbox')).to eq({})
    end
  end

  context '#config_read' do
    it do
      expect(http_client).to receive(:get)
                                 .with('/admin/api/services/42/proxy/configs/sandbox/5')
                                 .and_return('proxy_config' => {})
      expect(client.config_read(42, 'sandbox', 5)).to eq({})
    end
  end

end
