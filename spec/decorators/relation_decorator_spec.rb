require 'rails_helper'

RSpec.describe RelationDecorator do

  let(:user)          { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:subs) { create(:relation, relating_id: sub_user.id, related_id: user.id) }

  describe 'Subscriber#show.json' do
    subject { subs.decorate(context: { subscriber_show: true }).as_json }

    its([:id]) { should eq subs.id }

    its([:status]) { should eq 'subscriber' }

    its([:user]) { should eq user_show sub_user }
  end

  describe 'Subscriber#index.json' do
    subject { subs.decorate(context: { subscriber_index: true }).as_json }

    its([:id]) { should eq subs.id }

    its([:status]) { should eq 'subscriber' }

    its([:user]) { should eq user_index sub_user }
  end

  let(:subscribe) { create(:relation, relating_id: user.id, related_id: sub_user.id) }

  describe 'Subscribed#show.json' do
    subject { subscribe.decorate(context: {subscribed_show: true}).as_json }

    its([:id]) { should eq subscribe.id }

    its([:status]) { should eq 'subscribed' }

    its([:user]) { should eq user_show sub_user }
  end

  describe 'Subscribed#index.json' do
    subject { subscribe.decorate(context: {subscribed_index: true}).as_json }

    its([:id]) { should eq subscribe.id }

    its([:status]) { should eq 'subscribed' }

    its([:user]) { should eq user_index sub_user }
  end

  let(:ban) { create(:relation, relating_id: user.id, related_id: sub_user.id, state: 2) }

  describe 'Block#show.json' do
    subject      { ban.decorate(context: {block_show: true}).as_json }

    its([:id]) { should eq ban.id }

    its([:status]) { should eq 'banned' }

    its([:user]) { should eq user_show sub_user }
  end

  describe 'Block#index.json' do
    subject      { ban.decorate(context: {block_index: true}).as_json }

    its([:id]) { should eq ban.id }

    its([:status]) { should eq 'banned' }

    its([:user]) { should eq user_index sub_user }
  end

  describe '#Blocked?' do
    subject      { ban.decorate(context: {blocked: true}).as_json }
    
    its([:id]) { should eq ban.id }

    its([:status]) { should eq 'This user add you in black list' }

    its([:user]) { should eq user_index sub_user }
  end

  let(:friend_request) { create(:relation, relating_id: user.id, related_id: sub_user.id, state: 1) }

  let(:subscribe_response) { create(:relation, relating_id: sub_user.id, related_id: user.id, state: 1) }

  describe 'Friend#show.json' do
    subject { friend_request.decorate(context: {friend_show: true}).as_json }

    its([:id]) { should eq friend_request.id }

    its([:status]) { should eq 'friend' }

    its([:user]) { should eq user_show sub_user }
  end

  describe 'Friend#index.json' do
    subject { friend_request.decorate(context: {friend_index: true}).as_json }

    its([:id]) { should eq friend_request.id }

    its([:status]) { should eq 'friend' }

    its([:user]) { should eq user_index sub_user }
  end

  def profile_information(profile)
    {
      email: profile.email,
      number: profile.number,
      bday: profile.date,
      address: profile.address,
      relation:[{:id=>23, :name=>"Jarry Smith", :relations=>"Best friend"}, {:id=>23, :name=>"Jarry Smith", :relations=>"Best friend"}],
      location: "#{profile.country}, #{profile.locate}",
      about_self: profile.about
    }
  end

  def user_show(user)
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}",
      information: profile_information(user),
      wall: [],
      groups: 2,
      friends: 0,
      subscribers: 0,
      videos: 1,
      photos: 1,
      audios: 1
    }
  end

  def user_index(user)
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}"
    }
  end

  def user_relations(user)
    RelationsTypeGetter.new(user)
  end

end
