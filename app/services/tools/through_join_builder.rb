class Tools::ThroughJoinBuilder
  attr_reader :klass, :params, :c_user

  def initialize(args = {})
    args = default.merge(args)
    @klass  = args[:klass]
    @params = args[:params]
    @c_user = args[:c_user]
  end

  def build
    @builded_object = klass.new(params)
    @builded_object.users << c_user
    @builded_object
  end

  private

  def default
    { klass: nil, params: nil, c_user: nil }
  end
end
