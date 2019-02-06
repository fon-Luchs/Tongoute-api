require 'rails_helper'

RSpec.describe Relation, type: :model do
  it { should belong_to(:initiator) }
end
