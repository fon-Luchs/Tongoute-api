class Api::WallsController < BaseController

  include Relatable

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
    head 403 if relation_finder(current_user).blocked_users.exists?( related_id: destination_id ) 
  end
end
