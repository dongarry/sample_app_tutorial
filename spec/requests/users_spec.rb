require 'spec_helper'

describe "Users" do

	describe "signup" do

		describe "success" do
			#8.22
			it "should make a new user" do
				lambda do
					visit signup_path
					fill_in :user_name, :with => "Jim Test" #works the same as "Name"
					fill_in "Email", :with => "Jim@test.com"
					fill_in "Password", :with=>"JimPass"
					fill_in "Confirmation", :with=>"JimPass"
					click_button
					response.should render_template('users/show')
					response.should have_selector("div.flash.success",:content=>"Welcome")
				end.should change(User,:count).by(1)
			end
		end

		describe "failure" do
			#8.20
			it "should not make a new user" do
				lambda do
					visit signup_path
					fill_in "Name", :with => ""
					fill_in "Email", :with=>""
					fill_in "Password", :with=>""
					fill_in "Confirmation", :with=>""
					click_button
					response.should render_template('users/new')
					response.should have_selector("div#error_explanation")
					#shorthand for <div id="error_explanation">...</div>
				end.should_not change(User, :count)
			end
		end
	end



end
