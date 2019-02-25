require 'rails_helper'

RSpec.describe 'DeleteProfileSubscribing', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user) { create(:user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:relation) { create(:relation, related_id: sub_user.id, relating_id: user.id, id: 1) }

  context do
    before { delete '/api/profile/subscribings/1/remove', params: {} , headers: headers }
    
    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/subscribings/1/remove', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end