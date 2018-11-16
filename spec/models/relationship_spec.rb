require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it { should belong_to(:subscriber).class_name('User') }

  it { should belong_to(:subscribed).class_name('User') }

  it { should validate_presence_of(:subscriber_id) }

  it { should validate_presence_of(:subscribed_id) }
end
