require 'rails_helper'

RSpec.describe UserChat, type: :model do
  it { should belong_to(:chat) }

  it { should belong_to(:user) }

  it { should define_enum_for(:role) }

  describe "uniquness_of_relation" do
    let(:current_user) { create(:user) }

    let(:chat) { create(:chat, creator_id: 11) }
    
    before { UserChat.create! chat_id: chat.id, user_id: current_user.id }

    it { expect { UserChat.create! chat_id: chat.id, user_id: current_user.id }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
