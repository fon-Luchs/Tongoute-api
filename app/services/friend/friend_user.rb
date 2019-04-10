class Friend::FriendUser
  attr_reader :params, :relation

  def initialize(args={})
    args    = default.merge(args)
    @params = args[:params]
    @relation = args[:user_relation]
  end

  def call
    @f_user = relation.friends.find(params[:id]) if params[:id]
    @f_user = relation.friends.find(params[:friend_id]) if params[:friend_id]
    @f_user = relation.subscribers.find(params[:subscriber_id]) if params[:subscriber_id]
    @f_user
  end

  private

  def default
    { params: {}, user_relation: nil }
  end
end
