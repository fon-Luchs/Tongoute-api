require 'rails_helper'

RSpec.describe Relation, type: :model do
  it { should belong_to(:initiator) }

  it { should belong_to(:initiated) }

  it { should define_enum_for(:state) }

  describe "uniquness_of_relation" do
    let(:current_user) { create(:user) }

    let(:another_user) { create(:user) }

    context "by_table" do
      before { current_user.relations.create! related_id: another_user.id }

      it { expect { current_user.relations.create! related_id: another_user.id }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context "by_record" do
      it { expect { current_user.relations.create! related_id: current_user.id }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

end
