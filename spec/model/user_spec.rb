require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:reservations).dependent(:destroy) }
    it { should have_many(:cars).through(:reservations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'has_secure_password' do
    let(:user) { User.new(username: 'test_user', password: 'password') }

    it 'should set the password_digest attribute' do
      expect(user.password_digest).not_to be_nil
    end

    it 'should authenticate the user with the correct password' do
      expect(user.authenticate('password')).to eq(user)
    end

    it 'should not authenticate the user with the incorrect password' do
      expect(user.authenticate('wrong_password')).to eq(false)
    end
  end
end
