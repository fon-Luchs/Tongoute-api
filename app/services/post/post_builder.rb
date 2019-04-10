class Post::PostBuilder
  attr_reader :strong_params, :wall_owner, :postable

  def initialize(args = {})
    args = default.merge(args)
    @strong_params = args[:strong_params]
    @wall_owner = args[:wall_owner]
    @postable = args[:postable]
  end

  def build
    @post = postable.posts.new(strong_params.merge(wall_id: wall.id))
  end

  private

  def wall
    @wall = wall_owner.wall
  end

  def default
    { strong_params: {}, wall_owner: nil, postable: nil }
  end
end
