require 'securerandom'
require '3scale/api'

RSpec.describe 'Account Plan API', type: :integration do
  # WebMock::Config.instance.allow_net_connect = true
  endpoint = ENV.fetch('ENDPOINT')
  provider_key = ENV.fetch('PROVIDER_KEY')
  client = ThreeScale::API.new(endpoint: endpoint, provider_key: provider_key)
  name = SecureRandom.uuid
  account_plan = client.account_plan_create(name, name)
  describe do
    context '#account_plans_crud' do
      it 'creates an account plan' do
        expect(account_plan).to include('name' => name)
      end

      it 'list an account plan' do
        expect(client.account_plan_list.any? { |plan| plan['name'] == name }).to be(true)
      end

      # context '#account_plan_read' do
      #   subject(:read_plan) do
      #     client.account_plan_read(account_id)
      #   end
      #   it do
      #     expect(show).to include('id' => account_id)
      #   end
      # end
      #
      # context '#create_application' do
      #   let(:account_id) { sign_up.fetch('id') }
      #   subject(:create) do
      #     client.create_application(account_id,
      #                               plan_id: application_plan_id,
      #                               user_key: name,
      #                               application_id: name,
      #                               application_key: name)
      #   end
      #   it 'creates an application' do
      #     expect(create).to include('user_key' => name, 'service_id' => service_id)
      #   end
      #
      #   context '#show_application' do
      #     let(:application_id) { create.fetch('id') }
      #
      #     subject(:show) { client.show_application(application_id) }
      #
      #     it do
      #       expect(show).to include('id' => application_id, 'service_id' => service_id)
      #     end
      #   end
      #
      #   context '#find_application' do
      #     let(:application_id) { create.fetch('id') }
      #     let(:user_key) { create.fetch('user_key') }
      #
      #     it 'finds by id' do
      #       find = client.find_application(id: application_id)
      #       expect(find).to include('id' => application_id, 'service_id' => service_id)
      #     end
      #
      #     it 'finds by user_key' do
      #       find = client.find_application(user_key: user_key)
      #       expect(find).to include('id' => application_id, 'user_key' => user_key)
      #     end
      #
      #     pending 'finds by application_id' do
      #       find = client.find_application(application_id: user_key)
      #       expect(find).to include('id' => application_id, 'user_key' => user_key)
      #     end
      #   end
      #
      #   context '#customize_application_plan' do
      #     let(:application_id) { create.fetch('id') }
      #
      #     subject(:customize) { client.customize_application_plan(account_id, application_id) }
      #
      #     it 'creates custom plan' do
      #       expect(customize).to include('custom' => true, 'default' => false, 'state' => 'hidden')
      #       expect(customize['name']).to match('(custom)')
      #       expect(customize['system_name']).to match('custom')
      #     end
      #   end
      # end
    end
  end
end
