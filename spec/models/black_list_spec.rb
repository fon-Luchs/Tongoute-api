require 'rails_helper'

RSpec.describe BlackList, type: :model do
  it { should belong_to(:blocker).class_name('User') }

  it { should belong_to(:blocked).class_name('User') }

  it { should validate_presence_of(:blocker_id) }

  it { should validate_presence_of(:blocked_id) }
end
