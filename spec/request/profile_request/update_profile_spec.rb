require 'rails_helper'

RSpec.describe 'UpdateProfile', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_information)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { user: { first_name: "Ben", last_name: "Gun", email: "new@email.com" } } }

  let(:relations) do
    user.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
  end

  let(:friends) do
    user.relations.where(state: 1)
  end

  let(:info) do
    {
      "email" => user.email,
      "number" => user.number,
      "bday" => user.date,
      "relations" => relations,
      "location" => "#{user.country}, #{user.locate}",
      "address" => user.address,
      "about self" => user.about
    }
  end

  let(:profile_response) do
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
      "information" => info,
      "wall" => user.wall,
      "groups" => user.groups.count,
      "friends" => friends,
      "video" => user.videos,
      "photos" => user.photos,
      "audios" => user.audios,
      "notes" => user.notes,
      "bookmarks" => user.bookmarks
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