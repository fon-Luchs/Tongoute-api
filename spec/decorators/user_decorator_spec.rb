require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { profile.decorate(context: {profile: true}).as_json }

    its([:name]) { should eq 'Jarry Smith' }

    its([:information]) { should eq profile_information(profile) }

    its([:location]) { should eq "#{user.country}, #{user.locate}" }

    its([:wall]) { should eq Post.where(destination_id: user.id) }

    its([:groups])  { should eq groups }

    its([:friends]) { should eq FriendFinder.new(profile).all }
  end

  describe 'users#as_json' do
    let(:user) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    context '#show.json' do
      subject { user.decorate(context: {show: true}).as_json }

      its([:name]) { should eq 'Jarry Smith' }

      its([:information]) { should eq profile_information(user) }
    end

    context '#index.json' do
      subject { user.decorate(context: {index: true}).as_json }

      its([:name])     { should eq 'Jarry Smith' }

      its([:location]) { should eq "#{user.country}, #{user.locate}" }
    end
  end

  let(:user)          { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:relationship) { create(:relationship, subscriber_id: sub_user.id, subscribed_id: user.id) }

  describe 'Subscriber#show.json' do
    subject { sub_user.decorate(context: {subscriber_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscriber' }

    its([:information]) { should eq profile_information sub_user }

    its([:wall]) { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 0 }

    its([:subscribers]) { should eq 0 }

    its([:videos]) { should eq 1 }

    its([:photos]) { should eq 1 }

    its([:audios]) { should eq 1 }
  end

  describe 'Subscriber#index.json' do
    subject { sub_user.decorate(context: {subscriber_index: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscriber' }
  end

  let(:subscribe) { create(:relationship, subscriber_id: user.id, subscribed_id: sub_user.id) }

  describe 'Subscribed#show.json' do
    subject { sub_user.decorate(context: {subscribed_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscribed' }

    its([:information]) { should eq profile_information sub_user }

    its([:wall]) { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 0 }

    its([:subscribers]) { should eq sub_user.subscribers.count }

    its([:videos]) { should eq 1 }

    its([:photos]) { should eq 1 }

    its([:audios]) { should eq 1 }
  end

  describe 'Subscribed#index.json' do
    subject { sub_user.decorate(context: {subscribed_index: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscribed' }
  end

  describe 'Friend#show.json' do
    subject { sub_user.decorate(context: {friend_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Friend' }

    its([:information]) { should eq profile_information sub_user }

    its([:wall]) { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 0 }

    its([:subscribers]) { should eq sub_user.subscribers.count }

    its([:videos]) { should eq 1 }

    its([:photos]) { should eq 1 }

    its([:audios]) { should eq 1 }
  end

  describe 'Friend#index.json' do
    subject { sub_user.decorate(context: {friend_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Friend' }

  end

  describe '#blocked.json' do
    let(:user) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { user.decorate(context: {blocked: true}).as_json }

    its([:name])   { should eq 'Jarry Smith' }

    its([:status]) { should eq 'This user add you in black list' }
  end

  describe 'Block#show.json' do
    let(:b_user) { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

    subject      { b_user.decorate(context: {block_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status])      { should eq 'Banned' }

    its([:information]) { should eq profile_information(b_user) }

    its([:wall])    { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 0 }

    its([:subscribers]) { should eq b_user.subscribers.count }

    its([:videos])  { should eq 1 }

    its([:photos])  { should eq 1 }

    its([:audios])  { should eq 1 }
  end

  describe 'Block#index.json' do
    let(:b_user) { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

    subject      { b_user.decorate(context: {block_index: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status])      { should eq 'Banned' }
  end

  def groups
    [
      {
        id: 1,
        name: 'Tongoute Community',
        users: 133_221
      },

      {
        id: 1332,
        name: 'Slayer',
        users: 321_42
      }
    ]
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
end
