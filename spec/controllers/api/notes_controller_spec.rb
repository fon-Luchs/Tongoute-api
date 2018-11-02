require 'rails_helper'

RSpec.describe Api::NotesController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:note)  { create(:note, user: user) }

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

  let(:params) { { note: { title: title, body: body } } }

  let(:permitted_params) { permit_params! params, :note }

  describe 'routes test' do
    it { should route(:get, '/api/profile/notes/1').to(action: :show, controller: 'api/notes', id: 1) }

    it { should route(:put, '/api/profile/notes/1').to(action: :update, controller: 'api/notes', id: 1) }

    it { should route(:patch, '/api/profile/notes/1').to(action: :update, controller: 'api/notes', id: 1) }

    it { should route(:get, '/api/profile/notes').to(action: :index, controller: 'api/notes') }

    it { should route(:post, '/api/profile/notes').to(action: :create, controller: 'api/notes') }
  end

  describe '#create.json' do
    before do
      expect(user).to receive_message_chain(:notes, :new)
        .with(no_args).with(permitted_params)
        .and_return(note)
    end

    context 'success' do
      before { expect(note).to receive(:save).and_return(true) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context 'fail' do
      before { expect(note).to receive(:save).and_return(false) }

      before { merge_header }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:params) { { note: { title: title, body: body }, id: note.id } }

    before { expect(Note).to receive(:find).with(note.id.to_s).and_return(note) }

    context 'success' do
      before { expect(note).to receive(:update).and_return(true) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :update }
    end

    context 'fail' do
      before { expect(note).to receive(:update).and_return(false) }

      before { merge_header }

      before { put :update, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#delete.json' do
    before { merge_header }

    before { delete :destroy, params: { id: note.id.to_s }, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe '#show.json' do
    before { merge_header }

    before { get :show, params: { id: note.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe '#index.json' do
    before { merge_header }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
