require 'rails_helper'

RSpec.describe Post::PostBuilder do
  let(:user) { create(:user, :with_wall) }

  let(:wall_post) { build(:post, wall: user.wall, postable: user) }

  let(:params) { { post: { body: wall_post.body, wall_id: user.wall.id } } }

  let(:permitted_params) { permit_params! params, :post }

  subject { Post::PostBuilder.new(strong_params: permitted_params, wall_owner: user, postable: user) }

  describe '#build' do
    it { expect(subject.build.body).to eq(wall_post.body) }
  end
end
