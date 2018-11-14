require 'rails_helper'

RSpec.describe 'UnblockUser', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:b_user) { create(:user, id: 1) }

  let(:ban) { create(:block_user, user: user, blocked_id: b_user.id) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/users/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/users/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
