require 'rails_helper'

RSpec.describe Conversation::InterlocutorSetter do
  let(:user)  { create(:user) }

  let(:group) { create(:group, creator_id: user.id) }

  describe '#interlocutor_recipient for group' do
    let(:params) { { group_id: group.id  } }

    let(:strong_params) { permit_params! params }

    subject { Conversation::InterlocutorSetter.new(params, strong_params, user) }

    its(:interlocutor_recipient) { should eq group }
  end

  describe '#interlocutor_recipient for user' do
    let(:params) { { user_id: user.id  } }

    let(:strong_params) { permit_params! params }

    subject { Conversation::InterlocutorSetter.new(params, strong_params, user) }

    its(:interlocutor_recipient) { should eq user }
  end

  describe '#interlocutor_sender for as_group_id' do
    let(:params) { { as_group_id: group.id  } }

    let(:strong_params) { permit_params! params }

    subject { Conversation::InterlocutorSetter.new(params, strong_params, user) }

    its(:interlocutor_sender) { should eq group }
  end

  describe '#interlocutor_sender for as_group' do
    let(:params) { { group_id: group.id, as_group: true  } }

    let(:strong_params) { permit_params! params }

    subject { Conversation::InterlocutorSetter.new(params, strong_params, user) }

    its(:interlocutor_sender) { should eq group }
  end

  describe '#interlocutor_sender without params' do
    let(:params) { { } }

    let(:strong_params) { permit_params! params }

    subject { Conversation::InterlocutorSetter.new(params, strong_params, user) }

    its(:interlocutor_sender) { should eq user }
  end
end
