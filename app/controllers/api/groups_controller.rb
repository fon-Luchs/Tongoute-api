class Api::GroupsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @group = Group.new(resource_params.merge(creator_id: current_user.id))
    @group.users << current_user
    @group
  end

  def resource
    @group ||= current_user.groups.find(params[:id])
  end

  def collection
    @group = current_user.groups
  end

  def resource_params
    params.require(:group).permit(:name, :info)
  end
end
