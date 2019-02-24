class RelationObserver < ActiveRecord::Observer
  def after_create(relation)
    build_dual_relations!(relation, 'subscriber') if relation.state == 'subscriber'
  end

  def after_destroy(relation)
    build_dual_relations!(relation, 'friend') if relation.state == 'friend'
  end

  def after_update(relation)
    build_dual_relations!(relation, 'friend') if relation.state == 'banned'
  end

  private

  def build_dual_relations!(relation, type)
    if is_dual_relations?(relation, type)
      get_dual_relations(relation, type).update(state: get_state(Relation.states, type))
      relation.update(state: 1) if type == 'subscriber'
    end
  end

  def get_state(relation={}, type)
    state = relation.select{|k| k != 'banned' && k != type}
    state.values.first
  end

  def get_dual_relations(relation, type)
    Relation.send(type).find_by!(relating_id: relation.related_id, related_id: relation.relating_id)
  end

  def is_dual_relations?(relation, type)
    Relation.send(type).exists?(relating_id: relation.related_id, related_id: relation.relating_id)
  end

end
