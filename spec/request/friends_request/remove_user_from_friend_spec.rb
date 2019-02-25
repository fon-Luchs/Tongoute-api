require 'rails_helper'

RSpec.describe 'RemoveUserFromFriend', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1)}

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }
  
  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let!(:friendship)    { create(:relation, related_id: sub_user.id, relating_id: user.id, state: 1, id: 2 ) }

  describe 'Profile.friend#remove.json' do
  
    context do
      before { delete '/api/profile/friends/2/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 204') { expect(response).to have_http_status 204 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { delete '/api/profile/friends/2/remove', params: {} , headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

  end
end
