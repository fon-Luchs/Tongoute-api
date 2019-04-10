module BlackList::BannedHelper
  def self.call(c_user=nil, b_user=nil, params={})
    if params[:user_id]
      BlackList::PossiblyBanned.new(c_user: c_user, b_user: b_user).banned?
    elsif params[:friend_id] || params[:id]
      new_b_user = User.find(b_user.initiator.id)
      BlackList::PossiblyBanned.new(c_user: c_user, b_user: new_b_user).banned?
    end
  end
end
