require 'rails_helper'

RSpec.describe 'AcceptUserFriendInvite', type: :request do
  let(:user) { create(:user, :with_auth_token)}

  let(:sub_user) { create(:user) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_params) { attributes_for(:relationship) }

  let(:params) { { subscriber: resource_params } }

  let(:subscriber) { Relationship.last }

  let(:groups) do
    sub_user.groups.map do |group|
      { "id" => group.id, "name" => group.users, "users" => group.users.count }
    end
  end

  let(:relations) do
    sub_user.relations.map do |relation|
      { "id" => relation.user_id, "name" => relation.user_name, "relation" => relation.relation }
    end
  end

  let(:notes) do
    sub_user.notes.map do |note|
      { "id" => note.id, "title" => note.title, "body" => note.body }
    end
  end

  let(:info) do
    {
      "email" => sub_user.email,
      "number" => sub_user.number,
      "bday" => sub_user.date,
      "relations" => relations,
      "location" => "#{sub_user.country}, #{sub_userr.locate}",
      "address" => sub_user.adres,
      "about self" => sub_user.about
    }
  end

  let(:resource_response) do
    {
      "id" => sub_user.id,
      "name" => "#{sub_user.first_name} #{sub_user.last_name}",
      "status" => 'Friend request sended',
      "information" => info,
      "wall" => sub_user.wall,
      "groups" => sub_user.groups.count,
      "friends" => sub_user.friends,
      "video" => sub_user.videos,
      "photos" => sub_user.photos,
      "audios" => sub_user.audios
    }
  end

  before { create(:relationship, resource_params.merge(subscriber_id: user.id, subscribed_id: sub_user.id)) }

  describe 'Profile#accept.json' do

    context do
      before { post '/api/profile/subscribers/1/request', params: {}, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/profile/subscribers/1/request', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/profile/subscribers/1/request', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end

  end

  describe 'User#accept.json' do

    context do
      before { post '/api/users/1/request', params: {}, headers: headers }

      it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

      it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
    end

    context 'Unauthorized' do
      let(:value) { SecureRandom.uuid }

      before { post '/api/users/1/request', params: {}, headers: headers }

      it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
    end

    context 'invalid params' do
      before { post '/api/users/1/request', params: {}, headers: headers }

      it('returns HTTP Status Code 422') { expect(response).to have_http_status 422 }
    end

  end
end
