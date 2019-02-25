require 'rails_helper'

RSpec.describe 'PostUserSubscribing', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 2) }

  let(:s_user) { create(:user, id: 1) }

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:resource_response) do
    {
      "id" => relation.id,
      "status" => 'subscribed',
      "user" => {
        "audios" => 1,
        "friends" => 0,
        "groups" => 2,
        "id" => 1,
        "information" => {
          "about_self" => nil,
          "address"=>nil,
          "bday"=>nil,
          "email"=>"#{s_user.email}",
          "location"=> ", ", 
          "number"=>nil,
          "relation" => [{
              "id"=>23,
              "name"=>"Jarry Smith",
              "relations"=>"Best friend"
            },
            { "id"=>23,
              "name"=>"Jarry Smith",
              "relations"=>"Best friend"
            }]},
          "name"=>"#{s_user.first_name} #{s_user.last_name}",
          "photos"=>1,
          "subscribers"=>0,
          "videos"=>1,
          "wall"=>[]
        }
      }
  end

  before { build(:relation, related_id: s_user.id, relating_id: user.id) }

  let(:relation) { Relation.last }

  before { post '/api/users/1/request', params: {}, headers: headers }

  context do
    it('returns notes') { expect(JSON.parse(response.body)).to eq resource_response }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'Unauthorized' do
    let(:value) { SecureRandom.uuid }

    it('returns HTTP Status Code 401') { expect(response).to have_http_status :unauthorized }
  end
end