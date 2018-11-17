require 'rails_helper'

RSpec.describe RelationshipDecorator do
  let(:user)          { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:relationship) { create(:relationship, subscriber_id: sub_user.id, subscribed_id: user.id) }

  describe 'Subscriber#show.json' do
    subject { relationship.decorate(context: {subscriber_show: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscriber' }

    its([:information]) { should eq profile_information sub_user }

    its([:wall]) { should eq [] }

    its([:groups])  { should eq 2 }

    its([:friends]) { should eq 3 }

    its([:subscribers]) { should eq 3 }

    its([:videos]) { should eq 1 }

    its([:photos]) { should eq 1 }

    its([:audios]) { should eq 1 }
  end

  describe 'Subscriber#index.json' do
    subject { relationship.decorate(context: {subscriber_index: true}).as_json }

    its([:name]) { should eq 'Jeffrey Lebowski' }

    its([:status]) { should eq 'Subscriber' }
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
