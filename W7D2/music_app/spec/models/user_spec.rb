require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryBot.build(:user) }

  describe 'validations' do 
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
  
  describe "#is_password?" do
    correct = FactoryBot.build(:correct_pw)

    it "verifies a password is correct" do
      expect(correct.is_password?("correct")).to be true
    end

    it "verifies a password is not correct" do
      expect(user.is_password?("bad_password")).to be false
    end
  end

end
