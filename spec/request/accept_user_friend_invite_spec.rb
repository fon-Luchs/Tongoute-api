require 'rails_helper'

RSpec.describe 'AcceptUserFriendInvite', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:subscriber)    { create(:subscriber, user: user, subscriber_id: sub_user.id ) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:friend) }

  let(:params) { { friend: resource_params } }

  let(:friend) { Friend.last }

  let(:resource_response) do
    {
      "id" => friend.user.id,
      "name" => "#{friend.user.name} #{friend.user.last_name}",
      "status" => 'friend'
    }
  end

  before { create(:friend, resource_params.merge(user: user, friend_id: subscriber.subscriber_id)) }

  describe 'Profile#accept.json' do

    context do
      before { post '/api/profile/subscribers/1/accept', params: params.to_json, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/profile/subscribers/1/accept', params: params.to_json, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/profile/subscribers/1/accept', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end

  end

  describe 'User#accept.json' do

    context do
      before { post '/api/users/1/accept', params: params.to_json, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/users/1/accept', params: params.to_json, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/users/1/accept', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end

  end
end
