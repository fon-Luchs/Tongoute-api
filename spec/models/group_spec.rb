require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_one(:wall) }

  it { should have_many(:posts) }

  it { should have_many(:users) }

  it { should have_many(:user_groups) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:creator_id) }

  it { should have_many(:active_conversations) }

  it { should have_many(:pasive_conversations) }

  it { should have_many(:messages) }
end
