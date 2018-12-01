class Api::ConversationsController < BaseController
  private

  def resource
    @conversation = current_user.conversations.find(params[:id])
  end
end
