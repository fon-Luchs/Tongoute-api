require 'rails_helper'

RSpec.describe Relation::RelationsTypeGetter do
  let(:user) { create(:user) }

  subject { RelationsTypeGetter.new(user) }

  describe '#subscribers' do
    let(:sub_us) { create(:user) }

    let(:sub) { create(:relation, relating_id: sub_us.id, related_id: user.id) }

    its(:subscribers) { should eq [sub] }
  end

  describe '#friends' do
    let(:fr_us) { create(:user) }

    let(:fr) { create(:relation, relating_id: user.id, related_id: fr_us.id, state: 1) }

    its(:friends) { should eq [fr] }
  end

  describe '#subscribings' do
    let(:sub_us) { create(:user) }

    let(:sub) { create(:relation, relating_id: user.id, related_id: sub_us.id) }

    its(:subscribings) { should eq [sub] }
  end

  describe '#blocked_users' do
    let(:bl_us) { create(:user) }

    let(:bl) { create(:relation, relating_id: user.id, related_id: bl_us.id, state: 2) }

    its(:blocked_users) { should eq [bl] }
  end
end