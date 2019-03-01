class UserObserver < ActiveRecord::Observer
  def after_create(relation)
    Wall.create(wallable_id: relation.id, wallable_type: relation.class.name)
  end

  def after_destroy(relation)
    relation.wall.destroy
  end
end
