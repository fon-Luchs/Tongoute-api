require 'rails_helper'

RSpec.describe Subscribing::SubscribingUser do
  let(:current_user) { create(:user) }

  let(:user) { create(:user) }

  let(:subscribing) { create(:relation, related_id: user.id, relating_id: current_user.id) }

  let(:relation) { Relation::RelationsTypeGetter.new(current_user) }

  describe '#call :subscribing_id' do
    let(:params) { { subscribing_id: subscribing.id } }

    it { expect(subject.call(relation, params)).to eq subscribing }
  end

  describe '#call :id' do
    let(:params) { { id: subscribing.id } }

    it { expect(subject.call(relation, params)).to eq subscribing }
  end

  describe '#call :id' do
    let(:params) { { user_id: user.id } }

    it { expect(subject.call(relation, params)).to eq user }
  end
end
