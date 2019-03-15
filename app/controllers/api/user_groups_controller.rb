class Api::UserGroupsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @user_chat = UserGroup.find_or_initialize_by(resource_params)
  end

  def resource
    @user_chat ||= UserGroup.find_by!(resource_params)
  end

  def resource_params
    params.permit().merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
