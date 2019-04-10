module Post::WallOwnerSetter
  def self.call(params = {}, user = nil)
    onwer = if params[:user_id]
              User.find(params[:user_id])
            elsif params[:group_id]
              Group.find(params[:group_id])
            else
              user
            end
    onwer
  end
end
