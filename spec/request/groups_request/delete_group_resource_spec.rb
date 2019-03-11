require 'rails_helper'

RSpec.describe 'DeleteGroupResource', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let!(:group)   { create(:group, :with_wall, creator_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  before { group.users << user }

  context do
    before { delete '/api/profile/groups/1', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/profile/groups/1', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'group was not found' do
    before { get '/api/profile/groups/0', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
