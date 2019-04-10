class Api::GroupsController < BaseController
  before_action :build_resource, only: :create

  private

  def build_resource
    @group = builder.build
  end

  def resource
    @group ||= current_user.groups.find(params[:id])
  end

  def collection
    @groups = current_user.groups
  end

  def build_params
    resource_params.merge(creator_id: current_user.id)
  end

  def resource_params
    params.require(:group).permit(:name, :info)
  end

  def builder
    Tools::ThroughJoinBuilder.new(klass: Group, c_user: current_user, params: build_params)
  end
end
