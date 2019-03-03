require 'rails_helper'

RSpec.describe Wall, type: :model do
  it { should belong_to(:wallable) }

  it { should have_many(:posts) }

  it { should validate_presence_of(:wallable_id) }

  it { should validate_presence_of(:wallable_type) }
end
