require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  
  it { should belong_to(:sender).class_name('User') }

  it { should belong_to(:recipient).class_name('User') }

  it { should validate_presence_of(:sender_id) }

  it { should validate_presence_of(:recipient_id) }

  describe "uniquness_of_relation" do
    let(:current_user) { create(:user) }

    let(:another_user) { create(:user) }
    
    before { Conversation.create! recipient_id: current_user.id, sender_id: another_user.id }

    it { expect { Conversation.create! recipient_id: current_user.id, sender_id: another_user.id }
        .to raise_error(ActiveRecord::RecordInvalid) }
  end
end
