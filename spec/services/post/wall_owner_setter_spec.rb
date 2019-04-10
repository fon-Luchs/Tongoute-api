require 'rails_helper'

RSpec.describe Post::WallOwnerSetter do
  let(:current_user) { create(:user) }

  let(:user)  { create(:user) }

  let(:group) { create(:group, creator_id: current_user.id) }

  describe '#call with user' do
    let(:params) { { user_id: user.id } }

    it { expect(subject.call(params, current_user)).to eq user }
  end

  describe '#call with group' do
    let(:params) { { group_id: group.id } }

    it { expect(subject.call(params, current_user)).to eq group }
  end

  describe '#call with user' do
    let(:params) { { } }

    it { expect(subject.call(params, current_user)).to eq current_user }
  end
end
