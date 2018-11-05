require 'rails_helper'

RSpec.describe 'GetProfileSubFriendResource', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 1) }

  let(:subscriber) { create(:subscriber, user: user, id: 1) }

  let!(:friend) { create(:friend, user: subscriber, id: 1) }

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
    {
      "id" => user_friend.id,
      "name" => "#{user_friend.first_name} #{user_friend.last_name}",
      "status" => 'Friend',
      "information" => info,
      "wall" => user_friend.wall,
      "groups" => user_friend.groups.count,
      "friends" => user_friend.friends,
      "video" => user_friend.videos,
      "photos" => user_friend.photos,
      "audios" => user_friend.audios,
      "notes" => notes,
      "bookmarks" => user_friend.bookmarks
    }
  end

  before { create(:friend, resource_params.merge(user: user)) }

  context do
    before { post '/api/profile/subscribers/1/friends/1', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/profile/subscribers/1/friends/1', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
