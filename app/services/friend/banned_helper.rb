module Friend::BannedHelper
  def self.call(c_user = nil, b_user = nil, params = {})
    BlackList::PossiblyBanned.new(c_user: c_user, b_user: b_user).banned? if params[:user_id]
  end
end
