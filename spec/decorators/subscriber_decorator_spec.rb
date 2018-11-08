require 'rails_helper'

RSpec.describe SubscriberDecorator do
  let(:user)          { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:subscriber)    { create(:subscriber, user: user, subscriber_id: sub_user.id ) }

  describe '#create.json' do
    subject             { subscriber.decorate(context: { create: true }).as_json }

    its([:name])        { should eq 'Jarry Smith' }

    its([:status])      { should eq 'Friendship request sended' }

    its([:information]) { should eq profile_information(user) }

    its([:wall])    { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 2 }

    its([:videos])  { should eq 1 }

    its([:photos])  { should eq 1 }

    its([:audios])  { should eq 1 }
  end

  describe '#show.json' do
    subject    { subscriber.decorate.as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status])      { should eq 'Subscriber' }

    its([:information]) { should eq profile_information(sub_user) }

    its([:wall])    { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 2 }

    its([:videos])  { should eq 1 }

    its([:photos])  { should eq 1 }

    its([:audios])  { should eq 1 }
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
