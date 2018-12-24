class UserConversations
  
  attr_reader :user

  def initialize(user=nil)
    @user = user
  end

  def get_conversations
    Conversation.joins(:sender)
                .joins(:recipient)
                .where("conversations.recipient_id = ? or conversations.sender_id = ?", user.id, user.id)
  end
end