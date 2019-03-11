require 'rails_helper'

RSpec.describe GroupObserver, type: :observer do
    subject { described_class.send(:new) }

  let(:user) { create(:user) }

  let(:group) { create(:group, creator_id: user.id) }

  describe '#after_create' do
    before { expect(Wall).to receive(:create).with(wallable_id: group.id, wallable_type: group.class.name).and_return(true) }

    it { expect{subject.after_create(group)}.to_not raise_error }
  end

  describe '#after_destroy' do
    before { expect(group).to receive_message_chain(:wall, :destroy).and_return(true) }

    it { expect{subject.after_destroy(group)}.to_not raise_error }
  end
end
