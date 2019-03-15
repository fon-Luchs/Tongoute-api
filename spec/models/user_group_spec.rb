require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  it { should belong_to(:group) }

  it { should belong_to(:user) }

  it { should  validate_presence_of(:group) }

  it { should  validate_presence_of(:user) }

  describe "uniquness_of_relation" do
    let(:current_user) { create(:user) }

    let(:group) { create(:group, creator_id: current_user.id) }
    
    before { UserGroup.create! group_id: group.id, user_id: current_user.id }

    it { expect { UserGroup.create! group_id: group.id, user_id: current_user.id }.to raise_error(ActiveRecord::RecordInvalid) }
  end
end
