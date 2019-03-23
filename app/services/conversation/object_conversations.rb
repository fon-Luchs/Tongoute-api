module Conversation::ObjectConversations
  def self.call(object=nil)
    Conversation.includes(:senderable)
                .includes(:recipientable)
                .where("recipientable_id = ? or senderable_id = ?", object.id, object.id)
  end
end