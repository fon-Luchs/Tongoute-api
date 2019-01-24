require 'rails_helper'

RSpec.describe MessageDecorator do
  let(:user)  { create(:user, first_name: 'Jarry', last_name: 'Smith') }
  
  let(:chat)  { create(:chat, creator_id: user.id) }

  let(:message) { create(:message, messageable_type: chat.class.name, messageable_id: chat.id, user_id: user.id, text: 'LOL') }

  describe '#as_json' do
    subject { message.decorate.as_json }

    its([:author]) { should eq( { id: user.id, name: "Jarry Smith" } ) }

    its([:text])   { should eq message.text }
  end
end
