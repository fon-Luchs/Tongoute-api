require 'rails_helper'

RSpec.describe Subscribing::BannedHelper do
  let(:current_user) { create(:user) }

  let(:user)         { create(:user) }

  describe '#call user with self ban' do
    let(:params) { { user_id: user.id } }

    before { create(:relation, related_id: user.id, relating_id: current_user.id) }

    before { create(:relation, related_id: current_user.id, relating_id: user.id, state: 2) }

    it { expect(subject.call(current_user, user, params)).to eq(true) }
  end

  describe '#call user with self ban' do
    let(:params) { { id: user.id } }

    let(:subscribe) { create(:relation, related_id: user.id, relating_id: current_user.id) }

    before { create(:relation, related_id: current_user.id, relating_id: user.id, state: 2) }

    it { expect(subject.call(current_user, subscribe, params)).to eq(true) }
  end
end
