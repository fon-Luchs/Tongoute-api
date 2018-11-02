require 'rails_helper'

RSpec.describe Api::NoteDecorator do
  describe 'notes#as_json' do
    let(:user) { create(:user) }

    let(:note) { create(:note, user: user) }

    subject { note.decorate.as_json }

    its([:title]) { should eq note.title }

    its([:body])  { should eq note.body }
  end
end
