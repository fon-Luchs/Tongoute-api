class UserChatDecorator < Draper::Decorator
  delegate_all
  decorates_associations :chat

  def as_json(*args)
    if[:user_join]
      {
        chat_message: "Joined to #{chat.name}"
      }
    end
  end

end
