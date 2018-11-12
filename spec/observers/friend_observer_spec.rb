require 'rails_helper'

RSpec.describe FriendObserver, type: :observer do
  let(:user)   { create(:user) }
  
  let(:sub_user) { create(:user) }

  let(:sub_response)    { create(:subscriber, user: sub_user, subscriber_id: user.id) }

  let(:friend_response) { create(:friend, user: sub_user, friend_id: sub_response.subscriber_id) }

  let(:subscriber)  { create(:subscriber, user: user, subscriber_id: sub_user.id) }

  let(:friend) { create(:friend, user: user, friend_id: subscriber.subscriber_id) }

  subject { described_class.send(:new) }

  describe '#after_create' do
    before { expect(User).to receive(:find).with(friend.friend_id).and_return(sub_user) }

    before do
      expect(sub_user).to receive(:subscribers) do
        double.tap do |a|
          expect(a).to receive(:new).with( { subscriber_id: user.id } )
            .and_return(sub_response)
        end
      end
    end

    before { expect(sub_response).to receive(:save).and_return(true) }
    
    before do
      expect(sub_user).to receive_message_chain(:friends, :new)
        .with(no_args).with( { friend_id: friend.user.id } )
        .and_return(friend_response)
    end

    before { expect(friend_response).to receive(:save).and_return(true) }

    before do
      expect(user).to receive_message_chain(:subscribers, :find_by)
        .with(no_args).with( { subscriber_id: sub_user.id } )
        .and_return(subscriber)
    end

    before { expect(subscriber).to receive(:destroy).and_return(true) }

    

    xit { expect{ subject.after_create(friend) }.to_not raise_error }
  end

  describe '#after_destroy' do
    xit { expect{ subject.after_destroy }.to_not raise_error }
  end
end