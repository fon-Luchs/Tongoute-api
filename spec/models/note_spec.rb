require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should belong_to(:user) }

  it { validate_presence_of(:body) }

  it { validate_presence_of(:title) }
end
