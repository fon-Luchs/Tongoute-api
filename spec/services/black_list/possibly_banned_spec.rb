require 'rails_helper'

RSpec.describe BlackList::PossiblyBanned do
  subject { BlackList::PossiblyBanned.new(b_user: b_user, c_user: user) }

  let(:user)   { create(:user) }

  let(:b_user) { create(:user) }

  describe '#call' do
    before { create(:relation, related_id: user.id, relating_id: b_user.id, state: 2) }

    its(:banned?) { should eq true }
  end
end
