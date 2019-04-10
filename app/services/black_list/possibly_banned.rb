class BlackList::PossiblyBanned
  attr_reader :b_user, :c_user

  def initialize(args = {})
    args = default.merge(args)
    @b_user = args[:b_user]
    @c_user = args[:c_user]
  end

  def banned?
    relation.blocked_users.exists?(related_id: c_user.id)
  end

  private

  def relation
    @relation ||= Relation::RelationsTypeGetter.new b_user
  end

  def default
    {
      b_user: nil,
      c_user: nil
    }
  end
end
