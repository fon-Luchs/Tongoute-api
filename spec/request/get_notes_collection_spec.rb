require 'rails_helper'

RSpec.describe 'CreateNotes', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:note) { create(:note, user: user) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:note_response) do
    Note.all.map do |note|
      {
        "id" => note.id,
        "title" => note.title,
        "body" => note.body
      }
    end
  end

  context do
    before { get '/api/profile/notes', params: {} , headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq note_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/notes', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end