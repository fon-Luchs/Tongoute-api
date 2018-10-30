require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it { should be_a BaseController }

  describe '#create.json' do
    let(:session) { double }

    let(:password) { FFaker::Internet.password }

    let(:email) { FFaker::Internet.email }

    let(:params) { { session: { email: email, password: password } } }

    let(:permitted_params) { permit_params! params, :session }

    before { expect(Session).to receive(:new).with(permitted_params).and_return(session) }

    context do
      before { expect(session).to receive(:save).and_return(true) }
      def resource
        @user ||= current_user
      end
      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context do
      before { expect(session).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { expect(response).to have_http_status(422) }
    end
  end

  describe '#destroy.json' do
    let(:user) { create(:user, :with_auth_token) }

    let(:value) { user.auth_token.value }

    let(:headers) do
      {
        'Authorization' => "Token token=#{value}",
        'Content-type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    before { sign_in user }

    before { merge_header }

    before do
      expect(user).to receive(:auth_token) do
        double.tap { |a| expect(a).to receive(:destroy) }
      end
    end

    before { delete :destroy, format: :json }

    it { expect(response).to have_http_status(204) }
  end

  describe 'routes test' do
    it { should route(:post, 'api/session').to(action: :create) }

    it { should route(:delete, 'api/session').to(action: :destroy) }
  end

  def merge_header
    request.headers.merge!(headers)
  end
end
