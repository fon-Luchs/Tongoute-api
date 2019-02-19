require 'rails_helper'

RSpec.describe Relation, type: :model do
  it { should belong_to(:initiator) }

  it { should belong_to(:initiated) }

  it { should define_enum_for(:state) }

  it { should validate_uniqueness_of(:related_id).scoped_to(:relating_id) }

  # it { should validate_uniqueness_of(:related_id).scoped_to(:related_id) }
end
