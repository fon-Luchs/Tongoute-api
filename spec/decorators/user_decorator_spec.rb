require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { profile.decorate(context: {profile: true}).as_json }

    its([:name]) { should eq 'Jarry Smith' }

    its([:information]) { should eq profile_information(profile) }

    its([:location]) { should eq "#{profile.country}, #{profile.locate}" }

    its([:wall]) { should eq Post.where(destination_id: profile.id) }

    its([:groups])  { should eq groups }

    its([:friends]) { should eq [] }

    its([:subscribers]) { should eq [] }

    its([:subscribings]) { should eq [] }

    its([:black_list]) { should eq [] }
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

  describe '#blocked.json' do
    let(:user) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { user.decorate(context: {blocked: true}).as_json }

    its([:name])   { should eq 'Jarry Smith' }

    its([:status]) { should eq 'This user add you in black list' }
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
