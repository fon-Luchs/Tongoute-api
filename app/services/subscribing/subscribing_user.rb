module Subscribing::SubscribingUser
  def self.call(relation = nil, params = {})
    user = relation.subscribings.find(params[:subscribing_id]) if params[:subscribing_id]
    user = relation.subscribings.find(params[:id]) if params[:id]
    user = User.find(params[:user_id]) if params[:user_id]
    user
  end
end
