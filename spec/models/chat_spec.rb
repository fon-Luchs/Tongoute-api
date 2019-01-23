require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { should have_many(:user_chats) }

  it { should have_many(:users) }

  it { should have_many(:messages) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:creator_id) }
end
