require 'rails_helper'

RSpec.describe 'DeleteWallResource', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:post) { create(:post, user: user, id: 2) }

  describe 'Profile#delete' do
    context do
      before { delete '/api/profile/walls/2', params: {} , headers: headers }

      it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { delete '/api/profile/walls/2', params: {} , headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end

  describe 'User#delete' do
    context do
      before { delete '/api/users/1/walls/2', params: {} , headers: headers }

      it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { delete '/api/users/1/walls/2', params: {} , headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end
  end
end
