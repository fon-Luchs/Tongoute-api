class Api::BlockUsersController < BaseController
  before_action :build_resource, only: :create

  def destroy
    relation.blocked_users.delete set_user
    head 204
  end

  private

  def build_resource
    @block_user = current_user.relations.new(build_params)
  end

  def resource
    @block_user ||= set_user
  end

  def collection
    @block_users = relation.blocked_users
  end

  def build_params
    resource_params.merge(related_id: set_user.id)
  end

  def resource_params
    params.permit.merge(state: 2)
  end

  def set_user
    BlackList::BannedUser.new(params: params, user_relation: relation).call
  end

  def relation
    Relation::RelationsTypeGetter.new current_user
  end

  def banned?
    BlackList::BannedHelper.call(current_user, resource, params)
  end
end
