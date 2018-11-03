class Api::WallsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @post = current_user.posts.new(resource_params)
  end

  def resource
    @post ||= Post.find_by!(id: params[:id], destination_id: destination_id)
  end

  def collection
    @posts = Post.all.where(destination_id: destination_id)
  end

  def resource_params
    params.require(:post).permit(:title, :body).merge(destination_id: destination_id)
  end

  def destination_id
    id = params[:user_id] || current_user.id
    id
  end
end
