require 'rails_helper'

RSpec.describe WallDecorator do
  let(:user) { create(:user) }

  let(:wall)    { create(:wall, wallable: user) }

  let(:post)    { create(:post, wall: wall, postable: user) }
  
  describe 'user#wall' do
    subject { wall.decorate(context: { user_wall: true }).as_json }
    
    its([:owner]) { should eq( { id: user.id, name: "#{user.first_name} #{user.last_name}" } ) }

    its([:posts]) { should eq([post.decorate(context: { user_wall: true }).as_json]) }
  end
end
