require 'rails_helper'

RSpec.describe User, type: :model do
  #subject(:user) { User.new(email: "example@email.com", password: 'password') }
  subject(:user) { FactoryBot.build(:user) }

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:session_token) }

    it "should validate presence of password_digest" do
      user = FactoryBot.build(:user, password_digest: nil)
      user.valid?
      expect(user.errors[:password_digest]).to eq(["Password can't be blank."])
    end

    it "should validate password length" do
      short_password = FactoryBot.build(:user, password: "pass")
      short_password.valid?
      expect(short_password.errors[:password]).to eq(["is too short (minimum is 6 characters)"])
    end
  end

  describe "associations" do

  end

  describe "class methods" do
    describe "::find_by_credentials" do
      subject(:user) { FactoryBot.create(:user) }

      it "should find user by credentials" do
        user.valid?
        email = user.email
        password = user.password
        found_user = User.find_by(email: email)
        expect(found_user).to eq(user)
        expect(user.is_password?(password)).to eq (true)
      end
    end

    describe "#is_password?" do
      subject(:user) { FactoryBot.create(:user) }

      it "should check if correct password" do
        password = user.password
        expect(BCrypt::Password.new(user.password_digest)).to eq(password)
      end

      it "verifies password is not correct" do
        expect(user.is_password?("passwords")).to eq false
      end
    end

    describe "#reset_session_token" do
      it "should reset session token" do
        user.valid?
        old_session_token = user.session_token
        user.reset_session_token!
        expect(user.reset_session_token!).to_not eq(old_session_token)
        expect(user.reset_session_token!).to eq(user.session_token)
      end
    end
  end
end
