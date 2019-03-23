class UserConversations
  
  attr_reader :object

  def initialize(object=nil)
    @object = object
  end

  def get_conversations
    Conversation.includes(:senderable)
                .includes(:recipientable)
                .where("recipientable_id = ? or senderable_id = ?", object.id, object.id)
  end
end
