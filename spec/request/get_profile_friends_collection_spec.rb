require 'rails_helper'

RSpec.describe 'GetProfileFriendCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:friend_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski', id: 1) }

  let(:subscribe)        { create(:relationship, subscribed: user, subscriber: friend_user) }

  let(:friend_subscribe) { create(:relationship, subscribed: friend_user, subscriber: user) }

  let(:friend_collection) { FriendFinder.new(user) }

  let!(:user_friend) { friend_user }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    friend_collection.all.map do |u|
    {  
      "id" => u.id,
      "name" => "#{u.first_name} #{u.last_name}",
      "status" => "Friend"
    }
    end
  end

  context do
    before { get '/api/profile/friends/', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/friends/', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
