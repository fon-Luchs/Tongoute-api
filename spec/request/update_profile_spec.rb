require 'rails_helper'

RSpec.describe 'UpdateProfile', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_information)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { user: { first_name: "Ben", last_name: "Gun", email: "new@email.com" } } }

  let(:relations) do
    user.info.relations.map do |relation|
      [{ "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }]
    end
  end

  let(:info) do
    user.info.map do |info|
      {
        "email" => user.email,
        "number" => user.number,
        "bday" => user.date,
        "address" => user.adres,
        "relations" => relations,
        "about self" => user.about
      }
    end
  end

  let(:profile_response) do
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
      "groups" => user.groups.count,
      "friends" => user.friends.count,
      "video" => user.videos.count,
      "photos" => user.photos.count,
      "audios" => user.audios.count,
      "information" => info
    }
  end
  
  context do
    before { put '/api/profile', params: params.to_json, headers: headers }

    it('returns updated_profile') { expect(JSON.parse(response.body)).to eq profile_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'invalid attributes' do
    before { put '/api/profile', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { put '/api/profile', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end