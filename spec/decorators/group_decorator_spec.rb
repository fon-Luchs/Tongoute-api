require 'rails_helper'

RSpec.describe GroupDecorator do
  let(:user)  { create(:user) }
  
  let(:group)  { create(:group, :with_wall, creator_id: user.id) }

  let(:post) { create(:post, wall: group.wall, postable: group) }

  let(:decorated_message) { message.decorate.as_json }

  before { group.users << user }

  describe 'create#json' do
    subject { group.decorate(context: { group_show: true }).as_json }

    its([:id]) { should eq group.id }

    its([:name]) { should eq group.name }

    its([:author]) { should eq author }

    its([:users]) { should eq group.users }

    its([:wall]) { should eq group.wall }
  end

  describe 'index#json' do
    subject { group.decorate(context: { group_index: true }).as_json }

    its([:id]) { should eq group.id }

    its([:name]) { should eq group.name }

    its([:author]) { should eq author }
  end

  def author
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}"
    }
  end
end
