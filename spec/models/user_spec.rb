require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new({:first_name => "John", :last_name => "Doe", :email => "johndoe@test.com", :password => "test", :password_confirmation => "test"})
  end
  
  describe "Validations" do
    
    it "Should save a new user if all fields are set (with matching password and confirmation)" do
      @user.save
      expect(@user).to be_valid
    end

    it "Should not save if password and password confirmation do not match" do
      @user.password = "wrongpass"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "Should not save if email is not set" do 
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "Should not save if first name is not set" do 
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "Should not save if last name is not set" do 
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "Should not save if password length is less than 4" do 
      @user.password = "bad"
      @user.password_confirmation = "bad"
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe ".authenticate_with_credentials" do

    it "Should not be nil if valid email and password are entered" do
      @user.email = "johndoe@test.com"
      @user.password = "test"
      @user.save
      result = User.authenticate_with_credentials(@user.email, @user.password)
      expect(result).to_not be_nil
    end

    it "Should return nil if password is incorrect" do
      @user.email = "johndoe@test.com"
      @user.password = "wrong"
      @user.save
      result = User.authenticate_with_credentials(@user.email, @user.password)
      expect(result).to be_nil
    end

    it "Should not be nil if spaces are added before email address" do
      @user.email = "  johndoe@test.com"
      @user.password = "test"
      @user.save
      result = User.authenticate_with_credentials(@user.email, @user.password)
      expect(result).to_not be_nil
    end

    it "Should not be nil if spaces are added after email address" do
      @user.email = "johndoe@test.com  "
      @user.password = "test"
      @user.save
      result = User.authenticate_with_credentials(@user.email, @user.password)
      expect(result).to_not be_nil
    end

    it "Should not be nil if wrong case is used in email" do
      @user.email = "jOHndOe@test.com"
      @user.password = "test"
      @user.save
      result = User.authenticate_with_credentials(@user.email, @user.password)
      expect(result).to_not be_nil
    end
  end
end
