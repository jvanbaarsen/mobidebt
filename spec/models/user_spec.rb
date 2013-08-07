require 'spec_helper'
describe User do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
    it {should validate_numericality_of :credits}
    it "accepts a valid email address" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end

    it "refuses an invalid email address" do
      user = FactoryGirl.build(:user, email: 'invalid@mail')
      expect(user).not_to be_valid
    end
    it "should accept a negative credit amount" do
      user = FactoryGirl.build(:user, credits: -10)
      expect(user).to be_valid
    end
  end
end
