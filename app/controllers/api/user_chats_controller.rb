class Api::UserChatsController < BaseController
  before_action :build_resource, only: :create

  def update
    if current_user.id == resource.creator_id
      render :errors unless resource.update(resource_params.merge(default_params.merge(:role)))
    else
      head 204
    end
  end

  private

  def build_resource
    @user_chat = UserChat.new(resource_params.merge( default_params.merge(role: 0) ))
  end

  def resource
    @user_chat ||= UserChat.find_by!(default_params)
  end

  def resource_params
    params.require(:user_chat).permit()
  end

  def default_params
    if params[:user_id]
      { chat_id: params[:chat_id] }.merge(user_id: params[:user_id])
    else
      { chat_id: params[:chat_id] }.merge(user_id: current_user.id)
    end
  end
end
