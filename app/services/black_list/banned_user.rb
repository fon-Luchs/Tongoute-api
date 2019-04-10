class BlackList::BannedUser
  attr_reader :params, :relation

  def initialize(args={})
    args    = default.merge(args)
    @params = args[:params]
    @relation = args[:user_relation]
  end

  def call
    @b_user = relation.friends.find(params[:friend_id]) if params[:friend_id]
    @b_user = relation.blocked_users.find(params[:id]) if params[:id]
    @b_user = User.find(params[:user_id]) if params[:user_id]
    @b_user
  end

  private

  def default
    { params: {}, user_relation: nil }
  end
end
