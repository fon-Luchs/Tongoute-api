require 'rails_helper'

RSpec.describe UserChat, type: :model do
  it { should belong_to(:chat) }

  it { should belong_to(:user) }

  it { should define_enum_for(:role) }
end
