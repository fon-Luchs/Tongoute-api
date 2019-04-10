require 'rails_helper'

RSpec.describe Tools::ThroughJoinBuilder do
  let(:group)  { build(:group, creator_id: user.id) }

  let(:params) do
    {
      group: {
        name: group.name,
        info: group.info
      }
    }
  end

  let(:permitted_params) { permit_params! params, :group }

  let(:user) { create(:user) }

  subject { Tools::ThroughJoinBuilder.new(klass: Group, c_user: user, params: permitted_params.merge(creator_id: user.id)) }

  describe '#build' do
    # its(:build) { should eq group }

    it { expect(subject.build.name).to eq(group.name) }
  end
end
