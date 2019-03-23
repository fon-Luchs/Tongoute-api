require 'rails_helper'

RSpec.describe ConversationDecorator do
  let(:sender) { create(:user) }

  let(:recipient) { create(:user) }

  let(:conversations) { create(:conversation, senderable: sender, recipientable: recipient) }

  let(:messages) { Message.all }

  let(:decorated_message) { messages.decorate.as_json }

  before { create(:message, messageable_type: conversations.class.name, messageable_id: conversations.id, user_id: sender.id, text: 'LOL') }

  describe 'show#json' do
    subject { conversations.decorate(context: {id: sender.id, type: sender.class.name}).as_json }

    its([:id])   { should eq conversations.id }

    its([:interlocutor]) { should eq interlocutor(recipient, recipient.class.name) }

    its([:messages]) { should eq decorated_message }
  end
  
  describe 'index#json' do
    subject { conversations.decorate(context: {conversations_index: {id: sender.id, type: sender.class.name}}).as_json }

    its([:id])   { should eq conversations.id }

    its([:interlocutor]) { should eq interlocutor(recipient, recipient.class.name) }

    its([:last_message]) { should eq messages.last.decorate.as_json }
  end

  def interlocutor(conversationable_object, type)
    {
      id: conversationable_object.id,
      name: "#{recipient.first_name} #{recipient.last_name}",
      type: type
    }
  end
end
