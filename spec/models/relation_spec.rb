require 'rails_helper'

RSpec.describe Relation, type: :model do
  it { should belong_to(:initiator) }

  it { should belong_to(:initiated) }

  it { should define_enum_for(:state) }
end
