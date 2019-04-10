require 'rails_helper'

RSpec.describe BlackList::BannedHelper do
  let(:current_user) { create(:user) }

  let(:user)         { create(:user) }

  describe '#call user without self ban' do
    let(:params) { { user_id: user.id } }

    it { expect(subject.call(current_user, user, params)).to eq(false) }
  end

  describe '#call user with self ban' do
    let(:params) { { user_id: user.id } }

    before { create(:relation, related_id: current_user.id, relating_id: user.id, state: 2) }

    it { expect(subject.call(current_user, user, params)).to eq(true) }
  end

  describe '#call friend without self ban' do
    let(:params) { { friend_id: friend.id } }

    let(:friend) { create(:relation, related_id: current_user.id, relating_id: user.id, state: 1) }

    it { expect(subject.call(current_user, friend, params)).to eq(false) }
  end

  describe '#call banned user with self ban' do
    let(:params) { { id: ban.id } }

    let(:ban)    { Relation.first }

    before { create(:relation, related_id: current_user.id, relating_id: user.id, state: 2) }

    before { create(:relation, related_id: user.id, relating_id: current_user.id, state: 2) }

    it { expect(subject.call(current_user, ban, params)).to eq(true) }
  end
end
