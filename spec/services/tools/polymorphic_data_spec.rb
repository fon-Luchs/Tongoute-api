require 'rails_helper'

RSpec.describe Tools::PolymorphicData do
  let(:user) { create(:user) }

  describe '#call' do
    let(:res) { { id: user.id, type: user.class.name } }

    it { expect(subject.call(user)).to eq(res) }
  end
end
