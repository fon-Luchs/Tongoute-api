require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  it { should belong_to(:user) }

  let(:user) { create(:user) }

  subject { build(:subscriber, user: user) }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:subscriber_id) }

  let(:subscriber) { build(:subscriber, user: user, subscriber_id: user.id) }

  it { expect(subscriber).to_not be_valid }
end
