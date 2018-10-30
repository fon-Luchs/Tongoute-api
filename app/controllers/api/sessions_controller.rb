class Api::SessionsController < BaseController
  skip_before_action :authenticate!, only: :create

  def create
    head 422 unless resource.save
  end

  def destroy
    @session = current_user
    @session.auth_token.destroy
    head 204
  end

  private

  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
