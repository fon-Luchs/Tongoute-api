require 'rails_helper'

RSpec.describe ConversationDecorator do
  let(:sender) { create(:user) }

  let(:recipient) { create(:user) }

  let(:conversations) { create(:conversation, sender: sender, recipient: recipient) }
  describe 'show#json' do
    subject { conversations.decorate(context: {conversations_show: true}).as_json }

    its([:id])   { should eq conversations.id }

    its([:name]) { should eq 'Migel Castoras' }
  end
end
