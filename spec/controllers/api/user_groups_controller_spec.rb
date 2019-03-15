require 'rails_helper'

RSpec.describe Api::UserGroupsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, '/api/groups/1/join').to(action: :create, controller: 'api/user_groups', group_id: 1) }
    
    it { should route(:delete, '/api/groups/1/leave').to(action: :destroy, controller: 'api/user_groups', group_id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:group)  { create(:group, creator_id: user.id, id: 1 ) }

  let(:user_group) { create(:user_group, group: group, user: user) }

  let(:value) { user.auth_token.value }

  let(:request_headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) { { user_group: { group_id: group.id.to_s, user_id: user.id } } }

  let(:permitted_params) { permit_params! params, :user_group }

  before { sign_in user }

  describe '#create#json' do
    let(:params)  { { group_id: group.id, user_group: { group_id: group.id.to_s, user_id: user.id } } }

    before { expect(UserGroup).to receive(:find_or_initialize_by).with(permitted_params).and_return(user_group) }

    context 'success' do
      before{ expect(user_group).to receive(:save).and_return(true) }

      before{ merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before{ expect(user_group).to receive(:save).and_return(false) }

      before{ merge_headers request_headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'delete#json' do
    before { expect(UserGroup).to receive(:find_by!).with(permitted_params).and_return(user_group) }

    before { merge_headers request_headers }

    before { delete :destroy, params: { group_id: group.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
