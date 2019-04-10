require 'rails_helper'

RSpec.describe Friend::BannedHelper do
  let(:current_user) { create(:user) }

  let(:user)         { create(:user) }

  describe '#call user with self ban' do
    let(:params) { { user_id: user.id } }

    let(:u_friend) { create(:user) }

    before { create(:relation, related_id: u_friend.id, relating_id: user.id) }

    before { create(:relation, related_id: user.id, relating_id: u_friend.id) }

    before { create(:relation, related_id: current_user.id, relating_id: user.id, state: 2) }

    it { expect(subject.call(current_user, user, params)).to eq(true) }
  end

  describe '#call user with self ban' do
    let(:params) { { user_id: user.id } }

    it { expect(subject.call(current_user, user, params)).to eq(false) }
  end
end
