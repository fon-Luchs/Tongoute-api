require 'rails_helper'

RSpec.describe PostDecorator do
  let(:user) { create(:user, :with_wall) }

  let(:post) { create(:post, postable: user, wall_id: user.wall.id) }

  subject { post.decorate.as_json }

  its([:body])  { should eq post.body }

  its([:author]){ should eq author }

  its([:likes]) { should eq 332 }

  def author
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}"
    }
  end
end
