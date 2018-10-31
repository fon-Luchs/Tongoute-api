require 'rails_helper'

RSpec.describe 'GetUsersCollection', type: :request do
  before { create_list(:user, 3, :with_auth_token, :with_information) }

  let(:user) { create(:user, :with_auth_token, :with_information)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:users_collection) do
    User.all.map do |user|
      {
        "id" => user.id,
        "name" => "#{user.first_name} #{user.last_name}",
        "location" => "#{user.country}, #{user.locate}"
      }
    end
  end

  context do
    before { get '/api/users', params: {} , headers: headers }

    it('returns collection of users') { expect(JSON.parse(response.body)).to eq users_collection }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end
end