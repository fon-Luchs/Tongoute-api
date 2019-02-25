require 'rails_helper'

RSpec.describe 'GetProfileSubscribeResource', type: :request do
  let(:user) { create(:user, :with_auth_token) }

  let(:sub_user) { create(:user, id: 1) }

  let!(:relation) { create(:relation, related_id: sub_user.id, relating_id: user.id, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      'id' => relation.id,
      'status' => 'subscribed',
      'user' => {
        "audios" => 1,
        "friends" => 0,
        "groups" => 2,
        "id" => sub_user.id,
        "information" => {
          "about_self" => nil,
          "address" => nil,
          "bday" => nil,
          "email" => sub_user.email,
          "location"=>", ",
          "number" => nil,
          "relation" => [
            {
              "id" => 23,
              "name" => "Jarry Smith",
              "relations" => "Best friend"
            },
            {
              "id" => 23,
              "name" => "Jarry Smith",
              "relations" => "Best friend"
            }
          ]
        },
        "name"=>"#{sub_user.first_name} #{sub_user.last_name}",
        "photos"=>1,
        "subscribers"=>1,
        "videos"=>1,
        "wall"=>[]
      }
    }
  end

  context do
    before { get '/api/profile/subscribings/1', params: {}, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/subscribings/1', params: {}, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end
