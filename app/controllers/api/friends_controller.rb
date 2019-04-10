class Api::FriendsController < BaseController
  helper_method :current_id

  before_action :build_resource, only: :create

  private

  def build_resource
    @friend = current_user.relations.new(resource_params)
  end

  def resource
    @friend ||= set_resource
  end

  def collection
    @friends = relation.friends
  end

  def set_user
    params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def resource_params
    params.permit.merge(related_id: set_resource.initiator.id)
  end

  def set_resource
    Friend::FriendUser.new(params: params, user_relation: relation).call
  end

  def relation
    Relation::RelationsTypeGetter.new set_user
  end

  def banned?
    Friend::BannedHelper.call(current_user, resource, params)
  end

  def current_id
    current_user.id
  end
end
