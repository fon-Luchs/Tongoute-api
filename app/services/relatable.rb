module Relatable
  def relation_finder(user=nil)
    RelationsTypeGetter.new(user)
  end
end