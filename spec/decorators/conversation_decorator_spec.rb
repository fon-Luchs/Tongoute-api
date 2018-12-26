require 'rails_helper'

RSpec.describe ConversationDecorator do
  let(:sender) { create(:user) }

  let(:recipient) { create(:user) }

  let(:conversations) { create(:conversation, sender: sender, recipient: recipient) }
  describe 'show#json' do
    subject { conversations.decorate(context: {user_id: sender.id}).as_json }

    its([:id])   { should eq conversations.id }

    its([:name]) { should eq "#{recipient.first_name} #{recipient.last_name}" }

    its([:messages]) { should eq messages }
  end

  describe 'index#json' do
    subject { conversations.decorate(context: {conversations_index: true}).as_json }

    its([:id])   { should eq conversations.id }

    its([:name]) { should eq "#{recipient.first_name} #{recipient.last_name}" }
  end

  def messages
    [
      {
        name: 'Rudolf Gess',
        message: 'Hi dude!'
      },

      {
        name: 'Rudolf Gess',
        message: 'Heey?'
      }
    ]
  end
end
