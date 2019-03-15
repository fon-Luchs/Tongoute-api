require 'rails_helper'

RSpec.describe 'DeleteLeaveFromChat', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:creator) { create(:user) }

  let(:group)  { create(:group, creator_id: creator.id, id: 1) }

  let!(:join) { create(:user_group, group_id: group.id, user_id: user.id) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  context do
    before { delete '/api/groups/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { delete '/api/groups/1/leave', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'group was not found' do
    before { delete '/api/groups/0/leave', params: {}, headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
