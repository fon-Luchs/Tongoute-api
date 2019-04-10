class Conversation::InterlocutorSetter
  attr_reader :params, :strong_params, :current_user

  def initialize(params={}, strong_params={}, current_user=nil )
    @params = params
    @strong_params = strong_params
    @current_user = current_user
  end

  def interlocutor_sender
    get_sender
  end

  def interlocutor_recipient
    get_recipient
  end

  private

  def get_sender
    Group::AsGroupCheker.call(params, current_user)
  end

  def get_recipient
    params[:user_id] ? User.find(params[:user_id]) : Group.find(params[:group_id])
  end
end