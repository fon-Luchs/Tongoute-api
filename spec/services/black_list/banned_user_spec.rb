require 'rails_helper'

RSpec.describe BlackList::BannedUser do
  let(:user) { create(:user) }

  describe '#call for user_id' do
    let(:params) { { user_id: user.id } }

    subject { BlackList::BannedUser.new(params: params) }

    its(:call) { should eq user }
  end

  describe '#call for id' do
    subject { BlackList::BannedUser.new(params: params, user_relation: relations) }

    let(:params) { { id: relation.id } }

    let(:b_user) { create(:user) }

    let(:relations) { Relation::RelationsTypeGetter.new user }

    before { create(:relation, related_id: b_user.id, relating_id: user.id, state: 2) }

    let(:relation) { Relation.last }

    its(:call) { should eq relation }
  end

  describe '#call for friend_id' do
    subject { BlackList::BannedUser.new(params: params, user_relation: relations) }

    let(:params) { { friend_id: relation.id } }

    let(:b_user) { create(:user) }

    let(:relations) { Relation::RelationsTypeGetter.new user }

    before { create(:relation, related_id: b_user.id, relating_id: user.id, state: 1) }

    let(:relation) { Relation.last }

    its(:call) { should eq relation }
  end
end
