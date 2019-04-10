class Api::PostsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @post = Post::PostBuilder.new(
      strong_params: resource_params,
      wall_owner: wall_owner,
      postable: Group::AsGroupCheker.call(params, current_user)
    ).build
  end

  def resource
    @post ||= wall_owner.wall.posts.find(params[:id])
  end

  def resource_params
    params.require(:post).permit(:body)
  end

  def wall_owner
    Post::WallOwnerSetter.call(params, current_user)
  end

  def banned?
    false
  end
end
