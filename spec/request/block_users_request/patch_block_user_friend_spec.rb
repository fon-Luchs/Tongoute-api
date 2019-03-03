require 'rails_helper'

RSpec.describe 'BlockUserFriend', type: :request do
  let(:user) { create(:user, :with_auth_token, id: 2) }

  let(:b_user) { create(:user, :with_wall, id: 1) }
  
  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:params) { { block_user: resource_params } }

  let(:resource_params) { attributes_for(:relation) }

  before { create(:relation, resource_params.merge(related_id: b_user.id, relating_id: user.id, state: 1, id: 1)) }

  let(:block) { Relation.last }

  let(:owner) do
    {
      'id' => b_user.id,
      'name' => "#{b_user.first_name} #{b_user.last_name}"
    }
  end

  let(:posts) do
    b_user.wall.posts.map do |p|
      {
        'author' => owner,
        'body' => p.body,
        'id' => p.id,
        'likes' => 332
      }
    end
  end

  let(:wall) do
    {
      'id' => b_user.wall.id,
      'owner' => owner,
      'posts' => posts
    }
  end


  let(:block_response) do
    {
      "id" => 1,
      "status" => "banned",
      "user" => {
        "audios" => 1,
        "friends" => 0,
        "groups" => 2,
        "id" => 1,
        "information" => {
          "about_self" => nil,
          "address"=>nil,
          "bday"=>nil,
          "email"=>"#{b_user.email}",
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
          "name"=>"#{b_user.first_name} #{b_user.last_name}",
          "photos"=>1,
          "subscribers"=>0,
          "videos"=>1,
          "wall"=>wall
        }
      }
  end

  before { patch '/api/profile/friends/1/block', params: params.to_json, headers: headers }

  context do
    it('returns created block') { expect(JSON.parse(response.body)).to eq block_response }
  end
end
