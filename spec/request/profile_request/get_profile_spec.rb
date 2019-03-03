require 'rails_helper'

RSpec.describe 'GetProfile', type: :request do
  let(:user) { create(:user, :with_auth_token, :with_information)}

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

  let(:notes) do
    user.notes.map do |note|
      { "id" => note.id, "title" => note.title, "body" => note.body }
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

  let(:profile_response) do
    {
      "id" => user.id,
      "name" => "#{user.first_name} #{user.last_name}",
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


  context do
    before { get '/api/profile', params: {} , headers: headers }

    it('returns profile') { expect(JSON.parse(response.body)).to eq profile_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile', params: {} , headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end