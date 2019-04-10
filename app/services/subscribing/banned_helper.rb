module Subscribing::BannedHelper
  def self.call(c_user = nil, b_user = nil, params = {})
    ban = BlackList::PossiblyBanned.new(c_user: c_user, b_user: b_user).banned? if params[:user_id]
    ban = BlackList::PossiblyBanned.new(c_user: c_user, b_user: User.find(b_user.initiated.id)).banned? if params[:id]
    ban
  end
end
