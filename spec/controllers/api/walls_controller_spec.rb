require 'rails_helper'

RSpec.describe Api::WallsController, type: :controller do
  describe 'routes test' do
    it { should route(:get, '/api/users/1/walls/1').to(action: :show, controller: 'api/walls', user_id: 1, id: 1) }

    it { should route(:get, '/api/users/1/walls').to(action: :index, controller: 'api/walls', user_id: 1) }

    it { should route(:post, '/api/users/1/walls').to(action: :create, controller: 'api/walls', user_id: 1) }

    it { should route(:patch, '/api/users/1/walls/1').to(action: :update, controller: 'api/walls', user_id: 1, id: 1) }

    it { should route(:put, '/api/users/1/walls/1').to(action: :update, controller: 'api/walls', user_id: 1, id: 1) }

    it { should route(:delete, '/api/users/1/walls/1').to(action: :destroy, controller: 'api/walls', user_id: 1, id: 1) }

    it { should route(:post, '/api/profile/walls').to(action: :create, controller: 'api/walls') }

    it { should route(:patch, '/api/profile/walls/1').to(action: :update, controller: 'api/walls', id: 1) }

    it { should route(:put, '/api/profile/walls/1').to(action: :update, controller: 'api/walls', id: 1) }

    it { should route(:delete, '/api/profile/walls/1').to(action: :destroy, controller: 'api/walls', id: 1) }

    it { should route(:get, '/api/profile/walls/1').to(action: :show, controller: 'api/walls', id: 1) }

    it { should route(:get, '/api/profile/walls').to(action: :index, controller: 'api/walls') }
  end

  let(:user)  { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:post_) { create(:post, user: user) }

  before { sign_in user }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:title) { FFaker::LoremUA.sentence }

  let(:body)  { FFaker::LoremUA.paragraph }

  let(:params) { { post: { title: title, body: body, destination_id: user.id } } }

  let(:permitted_params) { permit_params! params, :post }

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:posts, :new)
        .with(no_args).with(permitted_params)
        .and_return(post_)
    end

    context 'Profile success' do
      before { expect(post_).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'Profile fail' do
      before { expect(post_).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end

    let(:params) { { post: { title: title, body: body, destination_id: user.id.to_s }, user_id: user.id } }

    context 'User success' do
      before { expect(post_).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'User fail' do
      before { expect(post_).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:params) { { post: { title: title, body: body }, id: post_.id } }

    before { expect(Post).to receive(:find_by!).and_return(post_) }

    context 'Profile success' do
      before { expect(post_).to receive(:update).and_return(true) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'Profile fail' do
      before { expect(post_).to receive(:update).and_return(false) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end

    let(:params) { { post: { title: title, body: body }, id: post_.id, user_id: user.id } }

    context 'User success' do
      before { expect(post_).to receive(:update).and_return(true) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'User fail' do
      before { expect(post_).to receive(:update).and_return(false) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: post_.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_header }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe '#destroy.json' do
    before { merge_header }

    before { delete :destroy, params: { id: post_.id.to_s }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
