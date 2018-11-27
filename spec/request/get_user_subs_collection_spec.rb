require 'rails_helper'

RSpec.describe 'GetUserSubsCollection', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1) }

  let(:sub_user) { create(:user) }

  let!(:subscriber) { create(:relationship, subscriber_id: sub_user.id, subscribed_id: user.id) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    Relationship.all.map do |s|
      s_user = User.find(s.subscriber_id)
      {
        "id" => s_user.id,
        "name" => "#{s_user.first_name} #{s_user.last_name}",
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
