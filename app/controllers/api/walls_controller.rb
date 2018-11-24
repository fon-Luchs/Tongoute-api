class Api::WallsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @post = current_user.posts.new(resource_params) unless banned?
  end

  def resource
    @post ||= Post.find_by!(id: params[:id], destination_id: destination_id) unless banned?
  end

  def collection
    @posts = Post.all.where(destination_id: destination_id) unless banned?
  end

  def resource_params
    params.require(:post).permit(:title, :body).merge(destination_id: destination_id)
  end

  def destination_id
    id = params[:user_id] || current_user.id
    id
  end

  def banned?
    if BlackList.exists?(blocker_id: destination_id, blocked_id: current_user.id)
      head 403
    end
  end
end
