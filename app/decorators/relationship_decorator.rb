class RelationshipDecorator < Draper::Decorator
  delegate_all
  decorates_associations :subscriber
  decorates_associations :subscribed

  def as_json(*args)

  end
  
end