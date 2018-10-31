require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    subject { profile.decorate(prifile_context).as_json }

    its([:name]) { should eq 'Jarry Smith' }

    its([:information]) { should eq profile_information(profile) }

    def prifile_context
      {
        context: {
          id: :id, name: :name, information: profile_information(profile),
          wall: :wall, groups: :groups, friends: :friends,
          videos: :videos, photos: :photos, audios: :audios,
          notes: :notes, bookmark: :bookmark
        }
      }
    end
  end

  describe 'users#as_json' do
    let(:user) { create(:user, first_name: 'Jarry', last_name: 'Smith') }

    context '#index.json' do
      subject { user.decorate(resource_context).as_json }

      its([:name]) { should eq 'Jarry Smith' }

      its([:information]) { should eq profile_information(user) }
    end

    context '#show.json' do
      subject { user.decorate(collection_context).as_json }

      its([:name]) { should eq 'Jarry Smith' }

      its([:location]) { should eq "#{user.country}, #{user.locate}" }
    end

    def resource_context
      {
        context: {
          id: :id, name: :name, information: profile_information(user),
          wall: :wall, groups: :groups, friends: :friends,
          videos: :videos, photos: :photos, audios: :audios
        }
      }
    end

    def collection_context
      {
        context: {
          id: :id, name: :name, location: :location
        }
      }
    end
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
