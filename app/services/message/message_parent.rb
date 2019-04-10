module Message::MessageParent
  def self.call(params = {})
    parent = Chat.find(params[:chat_id]) if params[:chat_id]
    parent = Conversation.find(params[:conversation_id]) if params[:conversation_id]
    parent
  end
end
