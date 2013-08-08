require 'spec_helper'
describe User do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_numericality_of :credits}

    it "does not validates password by default" do
      user = FactoryGirl.build(:user, password: nil)
      expect(user).to be_valid
    end

    it 'Validates user when validate_password is set to true' do
      user = FactoryGirl.build(:user, password: nil)
      user.validate_password = true
      expect(user).not_to be_valid
    end

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

  describe '.purchase_drink' do
    it 'deducts 2 credits from the users credits' do
      user = FactoryGirl.build(:user, credits: 10)
      user.stub(:save)
      user.purchase_drink
      expect(user.credits).to eq(8)
    end
  end

  describe '.purchase_snack' do
    it 'deducts 1 credit from the users credits' do
      user = FactoryGirl.build(:user, credits: 10)
      user.purchase_snack
      expect(user.credits).to eq(9)
    end
  end
end
