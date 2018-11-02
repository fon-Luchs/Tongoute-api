require 'rails_helper'

RSpec.describe 'DeleteNotes', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:note) { create(:note, user: user, id: 2) }

  context do
    before { delete '/api/profile/notes/2', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/notes/2', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
