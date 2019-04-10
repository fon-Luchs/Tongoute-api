module Group::AsGroupCheker
  def self.call(params = {}, user = nil)
    object = Group.find_by!(id: params[:as_group_id], creator_id: user.id) if params[:as_group_id]
    object = Group.find_by!(id: params[:group_id], creator_id: user.id) if params[:as_group]
    object ||= user
    object
  end
end
