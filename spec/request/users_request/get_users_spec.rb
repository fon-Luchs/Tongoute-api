require 'rails_helper'

RSpec.describe 'GetUser', type: :request do
  let!(:user) { create(:user, :with_auth_token, :with_information, id: 1)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:groups) do
    user.groups.map do |group|
      { "id" => group.id, "name" => group.users, "users" => group.users.count }
    end
  end

  let(:relations) do
    user.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
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

  let(:user_response) do
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
      "information" => info,
      "wall" => user.wall,
      "groups" => groups,
      "friends" => user.friends.count,
      "video" => user.videos,
      "photos" => user.photos,
      "audios" => user.audios
    }
  end

  context do
    before { get '/api/users/1', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq user_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/users/7', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end