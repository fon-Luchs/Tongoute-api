require 'rails_helper'

RSpec.describe Wall, type: :model do
  it { should belong_to(:wallable) }
end
