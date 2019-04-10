require 'rails_helper'

RSpec.describe Message::MessageResource do
  let(:user) { create(:user) }

  let(:chat) { create(:chat, creator_id: user.id) }

  let!(:message) { create(:message, user_id: user.id, messageable_id: chat.id, messageable_type: chat.class.name) }

  describe '#call' do
    it { expect(subject.call(user, chat)).to eq message }
  end
end
