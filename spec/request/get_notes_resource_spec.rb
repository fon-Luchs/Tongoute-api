require 'rails_helper'

RSpec.describe 'GetNotesResource', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let!(:note) { create(:note, user: user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:note_response) do
    {
      "id" => note.id,
      "title" => note.title,
      "body" => note.body
    }
  end

  context do
    before { get '/api/profile/notes/1', params: {} , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq note_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/notes/1', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
