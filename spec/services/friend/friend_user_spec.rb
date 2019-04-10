require 'rails_helper'

RSpec.describe Friend::FriendUser do
  let(:user) { create(:user) }

  let(:subscriber) { create(:user) }

  describe '#call for user_id' do
    let(:friend_response) { user.relations.last }

    let(:params) { { id: friend_response.id } }

    let(:relation) { Relation::RelationsTypeGetter.new user }

    before { create(:relation, related_id: subscriber.id, relating_id: user.id) }

    before { create(:relation, related_id: user.id, relating_id: subscriber.id) }

    subject { Friend::FriendUser.new(params: params, user_relation: relation) }

    its(:call) { should eq friend_response }
  end

  describe '#call for user_id' do
    let(:friend_response) { user.relations.last }

    let(:params) { { friend_id: friend_response.id } }

    let(:relation) { Relation::RelationsTypeGetter.new user }

    before { create(:relation, related_id: subscriber.id, relating_id: user.id) }

    before { create(:relation, related_id: user.id, relating_id: subscriber.id) }

    subject { Friend::FriendUser.new(params: params, user_relation: relation) }

    its(:call) { should eq friend_response }
  end

  describe '#call for user_id' do
    let(:friend_response) { Relation.last }

    let(:params) { { subscriber_id: friend_response.id } }

    let(:relation) { Relation::RelationsTypeGetter.new user }

    before { create(:relation, related_id: user.id, relating_id: subscriber.id) }

    subject { Friend::FriendUser.new(params: params, user_relation: relation) }

    its(:call) { should eq friend_response }
  end
end
