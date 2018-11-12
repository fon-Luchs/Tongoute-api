require 'rails_helper'

RSpec.describe Friend, type: :model do
  it { should belong_to(:user) }

  let(:user) { create(:user) }

  let(:friend) { build(:friend, user: user) }

  it { expect(friend).to_not be_valid }
end
