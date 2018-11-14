require 'rails_helper'

RSpec.describe BlockUserDecorator do
  let(:user)   { create(:user, first_name: 'Jarry', last_name: 'Smith') }

  let(:b_user) { create(:user, first_name: 'Jeffrey', last_name: 'Lebowski') }

  let(:ban)    { create(:block_user, user: user, blocked_id: b_user.id ) }
  
  subject      { ban.decorate.as_json }

  its([:name]) { should eq 'Jeffrey Lebowski' }

  its([:status])      { should eq 'Banned' }

  its([:information]) { should eq profile_information(b_user) }

  its([:wall])    { should eq [] }

  its([:groups])  { should eq 2 }

  its([:friends]) { should eq b_user.friends.count }

  its([:subscribers]) { should eq b_user.subscribers.count }

  its([:videos])  { should eq 1 }

  its([:photos])  { should eq 1 }

  its([:audios])  { should eq 1 }

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
