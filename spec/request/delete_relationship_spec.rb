require 'rails_helper'

RSpec.describe 'DeleteRelationship', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/profile/relations/1', params: {} , headers: headers }

    it("destroys current_user's relations") { expect(user.relations).to eq nil }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/relations', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
