require 'rails_helper'

RSpec.describe Api::GroupsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, 'api/profile/groups').to(action: :index, controller: 'api/groups') }

    it { should route(:get, 'api/users/1/groups').to(action: :index, controller: 'api/groups', user_id: 1) }

    it { should route(:get, 'api/groups/1').to(action: :show, controller: 'api/groups', id: 1) }

    it { should route(:post, 'api/groups').to(action: :create, controller: 'api/groups') }

    it { should route(:put, 'api/groups/1').to(action: :update, controller: 'api/groups', id: 1) }

    it { should route(:patch, 'api/groups/1').to(action: :update, controller: 'api/groups', id: 1) }

    it { should route(:delete, 'api/groups/1').to(action: :destroy, controller: 'api/groups', id: 1) }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:group)  { create(:group, creator_id: user.id ) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:params) do
    {
      group:
      {
        name: group.name,
        info: group.info,
        creator_id: group.creator_id
      }
    }
  end

  let(:permitted_params) { permit_params! params, :group }

  before { sign_in user }

  describe 'create#json' do
    before { expect(Group).to receive(:new).with(permitted_params).and_return(group) }

    before do
      expect(group).to receive_message_chain(:users, :<<)
        .with(no_args).with(user).and_return(group)
    end

    context 'success' do
      before { expect(group).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'false' do
      before { expect(group).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'update#json' do
    let(:params) { { group: { name: group.name, info: group.info }, id: group.id } }

    before do
      expect(user).to receive_message_chain(:groups, :find)
        .with(no_args).with(group.id.to_s)
        .and_return(group)
    end

    context 'success' do
      before { expect(group).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'false' do
      before { expect(group).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe 'delete#json' do
    before do
      expect(user).to receive_message_chain(:groups, :find)
        .with(no_args).with(group.id.to_s)
        .and_return(group)
    end

    before { merge_headers headers }

    before { delete :destroy, params: { id: group.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe 'show#json' do
    before { merge_headers headers }

    before { get :show, params: { id: group.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe 'index#json' do
    before { merge_headers headers }

    before { get :index, format: :json }

    it { should render_template :index }
  end
end
