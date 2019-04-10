module Message::MessageResource
  def self.call(current_user = nil, parent = nil)
    parent_data = Tools::PolymorphicData.call parent
    Message.find_by! user_id: current_user.id, messageable_id: parent_data[:id], messageable_type: parent_data[:type]
  end
end
