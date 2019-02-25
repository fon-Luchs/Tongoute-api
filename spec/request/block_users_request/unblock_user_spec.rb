require 'rails_helper'

RSpec.describe 'UnblockUser', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:b_user) { create(:user, id: 1) }

  let!(:block) { create(:relation, relating_id: user.id, related_id: b_user.id, state: 2, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/profile/blacklist/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/blacklist/1/unblock', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
