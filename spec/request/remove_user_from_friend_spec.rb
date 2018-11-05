require 'rails_helper'

RSpec.describe 'RemoveUserFromFriend', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:friend) { create(:friend, user: user) }

  describe 'User#remove.json' do

    context do
      before { delete '/api/users/1/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { delete '/api/users/1/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

  end

  describe 'Profile.friend#remove.json' do
  
    context do
      before { delete '/api/profile/friends/1/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { delete '/api/profile/friends/1/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

  end
end
