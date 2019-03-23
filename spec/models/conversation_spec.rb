require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  
  it { should belong_to(:senderable) }

  it { should belong_to(:recipientable) }

  it { should validate_presence_of(:senderable_id) }

  it { should validate_presence_of(:recipientable_id) }

  it { should validate_presence_of(:senderable_type) }

  it { should validate_presence_of(:recipientable_type) }

  describe "uniquness_of_relation" do
    let(:current_user) { create(:user, id: 1) }

    let(:another_user) { create(:user, id: 2) }

    let(:group) { create(:group, creator_id: another_user.id, id: 2 ) }
    
    before { Conversation.create! recipientable: current_user, senderable: another_user }

    it { expect { Conversation.create! recipientable: current_user, senderable: another_user }
        .to raise_error(ActiveRecord::RecordInvalid) }

    it { expect { Conversation.create! recipientable: current_user, senderable: group }.not_to raise_error }
  end
end
