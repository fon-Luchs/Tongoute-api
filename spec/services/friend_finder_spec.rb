require 'rails_helper'

RSpec.describe FriendFinder do
  let(:user) { create(:user) }

  subject { FriendFinder.new(user) }

  describe '#find' do
    it { expect(subject.find(user)).to eq(user) }
  end

  describe '#all' do
    its(:all) { should eq [] }
  end

end