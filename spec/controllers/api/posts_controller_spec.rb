require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  describe 'routes test' do
    it { should route(:post, '/api/profile/wall/posts').to(action: :create, controller: 'api/posts') }

    it { should route(:get, '/api/profile/wall/posts/1').to(action: :show, controller: 'api/posts', id: 1) }

    it { should route(:patch, '/api/profile/wall/posts/1').to(action: :update, controller: 'api/posts', id: 1) }

    it { should route(:delete, '/api/profile/wall/posts/1').to(action: :destroy, controller: 'api/posts', id: 1) }

    it { should route(:post, '/api/users/1/wall/posts').to(action: :create, controller: 'api/posts', user_id: 1) }

    it { should route(:get, '/api/users/1/wall/posts/1').to(action: :show, controller: 'api/posts', id: 1, user_id: 1) }

    it { should route(:patch, '/api/users/1/wall/posts/1').to(action: :update, controller: 'api/posts', id: 1, user_id: 1) }

    it { should route(:delete, '/api/users/1/wall/posts/1').to(action: :destroy, controller: 'api/posts', id: 1, user_id: 1) }
  end

  let(:user) { create(:user, :with_auth_token, :with_wall) }

  let(:wall_post)  { create(:post, postable: user, wall_id: user.wall.id) }

  let(:params) { { post: { body: wall_post.body, wall_id: user.wall.id } } }

  let(:permitted_params) { permit_params! params, :post }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  before { sign_in user }

  describe 'create#json' do
    before { expect(subject).to receive(:resource).and_return(wall_post) }

    context 'success' do
      before { expect(wall_post).to receive(:save).and_return(true) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(wall_post).to receive(:save).and_return(false) }

      before { merge_headers headers }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update' do
    let(:params) { { id: wall_post.id, post: { body: wall_post.body } } }

    before { expect(user).to receive_message_chain(:wall, :posts, :find).with(wall_post.id.to_s).and_return(wall_post) }

    context 'success' do
      before { expect(wall_post).to receive(:update).and_return(true) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(wall_post).to receive(:update).and_return(false) }

      before { merge_headers headers }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_headers headers }

    before { get :show, params: { id: wall_post.id }, format: :json }

    it { should render_template :show }
  end

  describe '#destroy.json' do
    before { expect(subject).to receive(:destroy) }

    before { merge_headers headers }

    before { delete :destroy, params: { id: wall_post.id }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

end
