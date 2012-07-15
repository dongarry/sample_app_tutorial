require 'spec_helper'

describe User do
  
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
  	@attr = {:name => "Example User", :email => "user@example.com"}
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



end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

