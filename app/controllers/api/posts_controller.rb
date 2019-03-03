class Api::PostsController < BaseController
  
  before_action :build_resource, only: :create

  include Relatable

  private

  def build_resource
    @post = current_user.posts.new(build_params)
  end

  def resource
    @post ||= set_object.wall.posts.find(params[:id])
  end

  def build_params
    params.require(:post).permit(:body).merge(wall_id: set_object.wall.id)
  end

  def resource_params
    params.require(:post).permit(:body)
  end
  
  def banned?
    head 403 if relation_finder(set_user).blocked_users.exists?( related_id: current_user.id ) 
  end

  def set_object
    object = User.find(params[:user_id]) if params[:user_id]   
    object ||= current_user
  end
end
