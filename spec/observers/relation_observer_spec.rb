require 'rails_helper'

RSpec.describe RelationObserver, type: :observer do

  subject { described_class.send(:new) }

  let(:user) { create(:user, id: 1) }

  let(:sub_user) { create(:user) }

  let(:relation) { create(:relation, related_id: sub_user.id, relating_id: user.id) }

  let(:inverse_relation) { create(:relation, relating_id: sub_user.id, related_id: user.id) }

  describe '#after_create' do
    before do
      expect(relation).to receive_message_chain(:state, :==)
        .with(no_args).with('subscriber').and_return(true)
    end

    before do
      expect(Relation).to receive(:subscriber) do
        double.tap do |r|
          expect(r).to receive(:exists?)
            .with(relating_id: relation.related_id, related_id: relation.relating_id)
            .and_return(true)
        end
      end
    end

    before do
      expect(Relation).to receive(:subscriber) do
        double.tap do |r|
          expect(r).to receive(:find_by!)
            .with(relating_id: relation.related_id, related_id: relation.relating_id)
            .and_return(inverse_relation)
        end
      end
    end

    before { expect(inverse_relation).to receive(:update).with(state: 1).and_return(true) }

    before { expect(relation).to receive(:update).with(state: 1).and_return(true) }

    it { expect{subject.after_create(relation)}.to_not raise_error }
  end

  let(:relation) { create(:relation, related_id: sub_user.id, relating_id: user.id, state: 1, state: 1) }

  let(:inverse_relation) { create(:relation, relating_id: sub_user.id, related_id: user.id, state: 1) }

  describe '#after_destroy' do
    before do
      expect(relation).to receive(:state) do
        double.tap { |r| expect(r).to receive(:==).with('friend').and_return(true) }
      end
    end

    before do
      expect(Relation).to receive(:friend) do
        double.tap do |r|
          expect(r).to receive(:exists?)
            .with(relating_id: relation.related_id, related_id: relation.relating_id)
            .and_return(true)
        end
      end
    end

    before do
      expect(Relation).to receive(:friend) do
        double.tap do |r|
          expect(r).to receive(:find_by!)
            .with(relating_id: relation.related_id, related_id: relation.relating_id)
            .and_return(inverse_relation)
        end
      end
    end

    before { expect(inverse_relation).to receive(:update).with(state: 0).and_return(true) }

    it { expect{subject.after_destroy(relation)}.to_not raise_error }
  end
end
