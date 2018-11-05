require 'rails_helper'

RSpec.describe 'GetProfileFriendCollection', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let!(:friend) { create(:friend, user: user, id: 1) }

  let!(:user_friend) { friend.user }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:groups) do
    user_friend.groups.map do |group|
      { "id" => group.id, "name" => group.users, "users" => group.users.count }
    end
  end

  let(:relations) do
    user_friend.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
  end

  let(:notes) do
    user_friend.notes.map do |note|
      { "id" => note.id, "title" => note.title, "body" => note.body }
    end
  end

  let(:info) do
    {
      "email" => user_friend.email,
      "number" => user_friend.number,
      "bday" => user_friend.date,
      "relations" => relations,
      "location" => "#{user.country}, #{user.locate}",
      "address" => user_friend.adres,
      "about self" => user_friend.about
    }
  end

  let(:resource_response) do
    user_friend.map do |user|
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
      "status" => 'Friend',
      "information" => info,
      "wall" => user.wall,
      "groups" => user.groups.count,
      "friends" => user.friends,
      "video" => user.videos,
      "photos" => user.photos,
      "audios" => user.audios,
      "notes" => notes,
      "bookmarks" => user.bookmarks
    }
    end
  end

  before { create(:friend, resource_params.merge(user: user)) }

  context do
    before { post '/api/profile/friends/', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/friends/', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
