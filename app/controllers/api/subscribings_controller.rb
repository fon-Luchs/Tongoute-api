class Api::SubscribingsController < BaseController

  before_action :build_resource, only: :create

  helper_method :friend_request?, :current_id

  private

  def build_resource
    @subscribed = current_user.relations.new(resource_params)
  end

  def resource
    @subscribed ||= get_object
  end

  def collection
    @subscibing = relation.subscribings
  end

  def resource_params
    params.permit.merge(related_id: get_object.id)
  end

  def get_object
    Subscribing::SubscribingUser.call(relation, params)
  end

  def friend_request?
    relation.friends.exists?(id: get_object.id)
  end

  def relation
    Relation::RelationsTypeGetter.new(current_user)
  end

  def banned?
    Subscribing::BannedHelper.call(current_user, get_object, params)
  end

  def current_id
    current_user.id
  end
end
