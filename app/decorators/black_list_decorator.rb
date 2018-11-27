class BlackListDecorator < Draper::Decorator
  delegate_all
  decorates_associations :blocker
  decorates_associations :blocked

  def as_json(*args)
    
  end
end
