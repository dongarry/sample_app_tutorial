require 'spec_helper'

describe User do
  
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
  	@attr = {:name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation=>"foobar"}
  end

  it "should create new instance given valid attributes" do
  	User.create!(@attr)
  end

  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name=>""))
  	no_name_user.should_not be_valid
  end

  it "should require a valid email address" do
  	no_email_user = User.new(@attr.merge(:email=>""))
	no_email_user.should_not be_valid	
  end

  it "should reject names that are over 50 characters" do
    long_name = "dong" * 16
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end 

  it "should be a valid email address" do
    addresses = %w[user@foo.com theuser@foo.foo.org first.last@somewhere.something]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email =>address))
      valid_email_user.should be_valid
    end
  end

  it "should NOT be a valid email address" do
    addresses = %w[user@foo,com theuserfoo.foo.org first.last@somewhere.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email =>address))
      valid_email_user.should_not be_valid
    end
  end

  it "should rejetc a duplicate email address" do
    User.create!(@attr)
    user_with_duplicate_details = User.new(@attr)
    user_with_duplicate_details.should_not be_valid 
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password=>"", :password_confirmation=>"")).should_not be_valid
    end
    it "should require a matching confirmation password" do
      User.new(@attr.merge(:password_confirmation=>"in_valid")).should_not be_valid 
    end    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password=>short, password_confirmation=>short)
      User.new(hash).should_not be_valid
      #User.new(@attr.merge(:password=>short, password_confirmation=>short)).should_not be_valid
    end
    it "should reject long passwords" do
      long = a*42
      hash = @attr.merge(:password=>long, password_confirmation=>long)
      User.new(hash).should_not be_valid
      #User.new(@attr.merge(:password=>short, password_confirmation=>short)).should_not be_valid      
    end
  end

  describe "user encryption" do
    before(:each) do
      @user=User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

  end

  describe "password encryption" do

    before(:each) do
      @user=User.create!(@attr) 
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
          @user.has_password?(@attr[:password]).should be_true
      end
      it "should be false if the passwords do NOT match" do
          @user.has_password?("Invalid").should be_false
      end

    end

    describe "authenticate password"

      it "should return nil on email/password mismatch" do
          wrong_password_user=User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
          nonexistent_user=User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
          matching_user=User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
      end

    end

  end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

