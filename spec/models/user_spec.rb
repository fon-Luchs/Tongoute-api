require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should have_one(:auth_token).dependent(:destroy) }

  it { should have_many(:groups) }

  it { should have_many(:friends) }

  it { should have_many(:videos) }

  it { should have_many(:notes).dependent(:destroy) }

  it { should have_many(:photos) }

  it { should have_many(:messages).dependent(:destroy) }

  it { should have_many(:chats) }

  it { should have_many(:likes) }

  it { should have_many(:reposts).dependent(:destroy) }

  it { should have_many(:posts) }

  it { should have_many(:audios) }

  it { should have_many(:bookmarks).dependent(:destroy) }

  it { should have_many(:documents) }

  it { should have_many(:relation).dependent(:destroy) }

  it { should have_one(:wall).dependent(:destroy) }

  it { should validate_presence_of(:first_name) }

  it { should validate_presence_of(:last_name) }
end
