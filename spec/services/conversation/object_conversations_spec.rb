require 'rails_helper'

RSpec.describe Conversation::ObjectConversations do
  let(:current_user) { create(:user) }

  let(:other_user)   { create(:user) }

  let(:recipient)    { create(:user) }
  
  let(:current_conversation) { create(:conversation, senderable: current_user, recipientable: recipient) }

  let(:other_conversation)   { create(:conversation, senderable: other_user, recipientable: recipient) }

  describe '#call' do
    it { expect(subject.call(current_user)).to eq([current_conversation]) }
  end
end