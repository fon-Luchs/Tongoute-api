require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { profile.decorate(prifile_context).as_json }

    its([:name]) { should eq 'Jarry Smith' }

    its([:information]) { should eq profile_information }
  end

  def prifile_context
    {
      context: {
        email: :email,
        name: :name,
        groups: :groups,
        friends: :friends,
        videos: :videos,
        photos: :photos,
        audios: :audios,
        information: :information
      }
    }
  end

  def profile_information
    {
      email: profile.email,
      number: profile.number,
      bday: profile.date,
      address: profile.address,
      relation:[{:id=>23, :name=>"Jarry Smith", :relations=>"Best friend"}, {:id=>23, :name=>"Jarry Smith", :relations=>"Best friend"}],
      about_self: profile.about
    }
  end
end
