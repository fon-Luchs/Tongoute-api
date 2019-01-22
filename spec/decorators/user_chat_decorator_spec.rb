require 'rails_helper'

RSpec.describe UserChatDecorator do
  let(:user)  { create(:user, :with_auth_token) }

  let(:chat)  { create(:chat, creator_id: user.id, id: 2 ) }

  let(:user_chat) { create(:user_chat, chat: chat, user: user, role: 0) }

  describe 'create#json' do
    subject { user_chat.decorate(context: { user_join: true } ).as_json }

    its([:chat_message]) { should eq "Joined to #{chat.name}" }
    
  end
end
