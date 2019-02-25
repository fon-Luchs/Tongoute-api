require 'rails_helper'

RSpec.describe 'ProfileBlackListResource', type: :request do
  let(:user)    { create(:user, :with_auth_token) }
  
  let(:b_user)  { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let!(:ban)     { create(:relation, related_id: b_user.id, relating_id: user.id, state: 2, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      "id" => ban.id,
      "status" => 'banned',
      "user" => {
        "audios" => 1,
        "friends" => 0,
        "groups" => 2,
        "id" => b_user.id,
        "information" => {
          "about_self" => nil,
          "address" => nil,
          "bday" => nil,
          "email" => "#{b_user.email}",
          "location" => ", ",
          "number" => nil,
          "relation" => [
            {
              "id"=>23,
              "name"=>"Jarry Smith",
              "relations"=>"Best friend"
            },
            {
              "id"=>23,
              "name"=>"Jarry Smith",
              "relations"=>"Best friend"
            }
          ]
        },
        "name"=>"Jeffrey Lebowski",
        "photos"=>1,
        "subscribers"=>0,
        "videos"=>1,
        "wall"=>[]
      }
    }
  end

  context do
    before { get '/api/profile/blacklist/1', params: { id: 1 }, headers: headers }

    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    before { get '/api/profile/blacklist', params: { id: 1 }, headers: headers }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end