require 'rails_helper'

RSpec.describe 'CreateNotes', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:note) }

  let(:params) { { note: resource_params } }

  let(:note) { Note.last }

  let(:note_response) do
    {
      "id" => note.id,
      "title" => note.title,
      "body" => note.body
    }
  end

  before { create(:note, resource_params.merge(user: user)) }

  context do
    before { post '/api/profile/notes', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq note_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/notes', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/profile/notes', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
