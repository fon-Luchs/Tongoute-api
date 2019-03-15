require 'rails_helper'

RSpec.describe UserGroupDecorator do
  let(:user)  { create(:user, :with_auth_token) }

  let(:group)  { create(:group, creator_id: user.id, id: 2 ) }

  let(:user_group) { create(:user_group, group: group, user: user) }

  describe 'create#json' do
    subject { user_group.decorate().as_json }

    its([:welcome]) { should eq "joined to #{group.name}" }
    
  end
end
