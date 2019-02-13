class Api::FriendsController < BaseController
  
  include Relatable
  
  before_action :build_resource, only: :create

  private

  def build_resource
    @friend = current_user.relations.new(resource_params)
  end

  def resource
    @friend ||= relation_finder(set_user).friends.find(params[:id])
  end

  def collection
    @friends = relation_finder(set_user).friends
  end

  def set_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def resource_params
    { related_id: set_user.id }
  end

  def banned?
    relation_finder(set_user).block_users.exists?( related_id: params[:user_id] )
  end
end
