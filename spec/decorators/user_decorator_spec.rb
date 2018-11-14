require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { profile.decorate(context: {profile: true}).as_json }

    its([:name]) { should eq 'Jarry Smith' }

    its([:information]) { should eq profile_information(profile) }
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

  describe '#banned.json' do
    let(:user) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { user.decorate(context: {banned: true}).as_json }

    its([:name])   { should eq 'Jarry Smith' }

    its([:status]) { should eq 'This user add you in black list' }
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
