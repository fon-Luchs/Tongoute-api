require 'rails_helper'

RSpec.describe RelationDecorator do

  let(:user)          { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:sub_user)      { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:subs) { create(:relation, relating_id: sub_user.id, related_id: user.id) }

  describe 'Subscriber#show.json' do
    subject { subs.decorate(context: { subscriber_show: true }).as_json }

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
    subject { subs.decorate(context: { subscriber_show: true }).as_json }

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

  def user_relations(user)
    RelationsTypeGetter.new(user)
  end

end
