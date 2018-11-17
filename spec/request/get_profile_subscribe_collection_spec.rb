require 'rails_helper'

RSpec.describe 'GetProfileSubscribeCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user) { create(:user, id: 1, first_name: 'Jarry') }
 
  let!(:subscriber) { create(:relationship, subscriber_id: sub_user.id, subscribed_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    user.subscribing.all.map do |s|
      {
        "id" => s.id,
        "name" => "Jarry #{s.last_name}",
        "status" => 'Subscribed'
      }
    end
  end

  context do
    before { get '/api/profile/subscribings/', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/subscribings/', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end