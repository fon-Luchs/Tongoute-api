require 'rails_helper'

RSpec.describe 'UnblockUser', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:block) { create(:block, user: user) }

  context do
    before { delete '/api/friends/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/friends/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end