class BlockUserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      
    }
  end
end
