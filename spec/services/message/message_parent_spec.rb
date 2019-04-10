require 'rails_helper'

RSpec.describe Message::MessageParent do
  let(:user) { create(:user) }

  let(:recipient) { create(:user) }

  describe '#call for chat' do
    let(:chat) { create(:chat, creator_id: user.id) }

    let(:params) { { chat_id: chat.id } }

    it { expect(subject.call(params)).to eq chat }
  end

  describe '#call for chat' do
    let(:conversation) { create(:conversation, senderable: user, recipientable: recipient) }

    let(:params) { { conversation_id: conversation.id } }

    it { expect(subject.call(params)).to eq conversation }
  end
end
