require 'rails_helper'

RSpec.describe UserObserver, type: :observer do
  subject { described_class.send(:new) }

  let(:user) { create(:user) }

  describe '#after_create' do
    before { expect(Wall).to receive(:create).with(wallable_id: user.id, wallable_type: user.class.name).and_return(true) }

    it { expect{subject.after_create(user)}.to_not raise_error }
  end

  describe '#after_destroy' do
    before { expect(user).to receive_message_chain(:wall, :destroy).and_return(true) }

    it { expect{subject.after_destroy(user)}.to_not raise_error }
  end
end
