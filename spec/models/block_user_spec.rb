require 'rails_helper'

RSpec.describe BlockUser, type: :model do
  it { should belong_to(:user) }

  let(:user) { create(:user) }

  subject { build(:block_user, user: user) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:blocked_id) }

  let(:blocked_user) { build(:block_user, user: user, blocked_id: user.id) }

  it { expect(blocked_user).to_not be_valid }
end
