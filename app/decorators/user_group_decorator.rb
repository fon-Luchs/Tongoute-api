class UserGroupDecorator < Draper::Decorator
  delegate_all

  decorates_associations :group

  def as_json(*args)
    {
      welcome: "joined to #{group.name}"
    }
  end
end
