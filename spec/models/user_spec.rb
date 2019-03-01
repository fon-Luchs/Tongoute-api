require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should have_one(:auth_token).dependent(:destroy) }

  it { should have_many(:groups) }

  it { should have_many(:videos) }

  it { should have_many(:notes).dependent(:destroy) }

  it { should have_many(:photos) }

  it { should have_many(:messages) }

  it { should have_many(:chats) }

  it { should have_many(:likes) }

  it { should have_many(:reposts).dependent(:destroy) }

  it { should have_many(:posts) }

  it { should have_many(:audios) }

  it { should have_many(:bookmarks).dependent(:destroy) }

  it { should have_many(:documents) }

  it { should have_many(:relations) }

  it { should have_many(:active_conversations) }

  it { should have_many(:pasive_conversations) }

  it { should have_one(:wall) }

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:last_name) }

  it { should validate_length_of(:about).is_at_least(5) }

  it { should allow_value('+3804388297').for(:number) }

  it { should validate_length_of(:address).is_at_least(5).is_at_most(35) }

  it { should validate_length_of(:country).is_at_least(2).is_at_most(35) }

  it { should validate_length_of(:locate).is_at_least(2).is_at_most(35) }

  it { should allow_value('14-07-1983').for(:date) }
end
