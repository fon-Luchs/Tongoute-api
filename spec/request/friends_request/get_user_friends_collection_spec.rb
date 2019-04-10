require 'rails_helper'

RSpec.describe 'GetProfileFriendCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }
  
  let!(:user_with_friend) { create(:user, id: 23) }

  let!(:friend_user) { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski', id: 1) }

  let(:friend)       { create(:relation, relating_id: user.id, related_id: friend_user.id, state: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    Relation.friend.map do |r|
      {
        "id" => r.id,
        "status" => r.state,
        "user" => {
          "id" => r.initiated.id,
          "name" => "#{r.initiated.first_name} #{r.initiated.last_name}"
        }
      }
    end
  end

  context do
    before { get '/api/users/23/friends', params: { user_id: 23 }, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/23/friends', params: { user_id: 23 }, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
