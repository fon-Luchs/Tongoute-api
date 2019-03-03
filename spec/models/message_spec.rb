require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:messageable) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:messageable_id) }
  
  it { should validate_presence_of(:messageable_type) }

  it { should validate_presence_of(:text) }

  it { should validate_presence_of(:user_id) }
end
