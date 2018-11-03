require 'rails_helper'

RSpec.describe PostDecorator do
  let(:user) { create(:user) }

  let(:post) { create(:post, user: user) }

  subject { post.decorate.as_json }

  its([:title]) { should eq post.title }

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
