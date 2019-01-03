require 'rails_helper'

RSpec.describe ChatDecorator do
  let(:user)  { create(:user) }
  
  let(:users) { create_list(:user, 2, first_name: 'Fidel', last_name: 'Castro') }

  let(:chat)  { create(:chat, creator_id: user.id) }

  before { chat.users << users }

  describe 'create#json' do
    subject { chat.decorate(context: { chat_show: true }).as_json }

    its([:id]) { should eq chat.id }

    its([:name]) { should eq chat.name }

    its([:author]) { should eq author }

    its([:users])  { should eq users }

    its([:messages]) { should eq [{context: 'lol'}] }
  end

  describe 'index#json' do
    subject { chat.decorate(context: { chat_index: true }).as_json }

    its([:id]) { should eq chat.id }

    its([:name]) { should eq chat.name }

    its([:author]) { should eq author }

    its([:last_message]) { should eq 'LOL' }
  end

  def author
    {
      id: user.id,
      name: "#{user.first_name} #{user.last_name}"
    }
  end

  def users
    chat.users.each do |u|
      {
        id: u.id,
        name: "#{u.first_name} #{u.last_name}",
        location: "#{u.country} #{u.locate}"
      }
    end
  end
end
