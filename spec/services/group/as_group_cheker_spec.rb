require 'rails_helper'

RSpec.describe Group::AsGroupCheker do
  let(:user)  { create(:user) }

  let(:group) { create(:group, creator_id: user.id) }

  describe '#call with :as_group' do
    let(:params) { { group_id: group.id, as_group: true } }

    it { expect(subject.call(params, user)).to eq(group) }
  end

  describe '#call with :as_group_id' do
    let(:params) { { as_group_id: group.id } }

    it { expect(subject.call(params, user)).to eq(group) }
  end

  describe '#call with User' do
    let(:params) { {} }

    it { expect(subject.call(params, user)).to eq(user) }
  end
end
