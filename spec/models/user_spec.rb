require 'rails_helper'

RSpec.describe User, :type => :model do

  describe 'validation' do
    it 'should not create with empty email' do
      user = User.create(:password => 'strangepwd')
      expect(user.save).to be_falsey
    end

    it 'should not create duplicate email' do
      Fabricate(:user)
      user = Fabricate.build(:user)
      expect(user).not_to be_valid
    end

    it 'should not accept invalid email' do
      user = Fabricate.build(:user, email: 'some@invalid')
      expect(user).not_to be_valid
    end

    it 'should not accept password less than 8 characters' do
      user = Fabricate.build(:user, password: 'abc')
      expect(user).not_to be_valid
    end
  end
end
