require 'rails_helper'

RSpec.describe 'InviteUserToFriend', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:subscriber) }

  let(:params) { { subscriber: resource_params } }

  let(:subscriber) { Subscriber.last }

  let(:requested_user) { subscriber.user }

  let(:groups) do
    requested_user.groups.map do |group|
      { "id" => group.id, "name" => group.users, "users" => group.users.count }
    end
  end

  let(:relations) do
    requested_user.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
  end

  let(:notes) do
    requested_user.notes.map do |note|
      { "id" => note.id, "title" => note.title, "body" => note.body }
    end
  end

  let(:info) do
    {
      "email" => requested_user.email,
      "number" => requested_user.number,
      "bday" => requested_user.date,
      "relations" => relations,
      "location" => "#{requested_user.country}, #{requested_userr.locate}",
      "address" => requested_user.adres,
      "about self" => requested_user.about
    }
  end

  let(:resource_response) do
    {
      "id" => requested_user.id,
      "name" => "#{requested_user.first_name} #{requested_user.last_name}",
      "status" => 'Friend request sended',
      "information" => info,
      "wall" => requested_user.wall,
      "groups" => requested_user.groups.count,
      "friends" => requested_user.friends,
      "video" => requested_user.videos,
      "photos" => requested_user.photos,
      "audios" => requested_user.audios
    }
  end

  before { create(:subbscriber, resource_params.merge(user: user)) }

  context do
    before { post '/api/users/1/request', params: params.to_json, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { post '/api/users/1/request', params: params.to_json, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end

  context 'invalid params' do
    before { post '/api/users/1/request', params: {}, headers: headers }

    it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
  end
end
