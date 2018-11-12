require 'rails_helper'

RSpec.describe 'GetUserSubsCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user) { create(:user, id: 1) }

  let!(:subscriber) { create(:subscriber, user: user, id: 1, subscriber_id: sub_user.id) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    user.subscribers.all.map do |s|
      {
        "id" => s.user.id,
        "name" => "#{s.user.first_name} #{s.user.last_name}",
        "status" => 'Subscriber'
      }
    end
  end

  context do
    before { get '/api/users/1/subscribers/', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/1/subscribers/', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
