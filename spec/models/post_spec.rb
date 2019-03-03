require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:postable) }

  it { should belong_to(:wall) }

  it { should validate_presence_of(:wall_id) }

  it { should validate_presence_of(:postable_id) }

  it { should validate_presence_of(:postable_type) }

  it { should validate_presence_of(:body) }
end
