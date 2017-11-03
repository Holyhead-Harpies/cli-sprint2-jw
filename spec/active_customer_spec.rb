require 'spec_helper'
describe CustomerController do

	context "user selects a customer" do
		before(:each) do
			@CustomerModel = CustomerModel.new
		end

		it "should set the current customer if it is an existing customer" do
			@current_active_customer = @CustomerModel.select_customer(1)
			expect(@current_active_customer).to eq(1)
		end
		it "should display 'Customer Does Not Exist' if it is an unexisting customer" do
			@current_active_customer = @CustomerModel.select_customer(2)
			expect(@current_active_customer).to eq('Customer Does Not Exist')
		end
	end

	# context "user selects an unexisting customer" do
	# 	before(:each) do

	# 	end

	# 	it "should ask the user to try again" do
	# 		@current_active_customer = @CustomerController.select_customer
	# 		expect(@current_active_customer).to eq(1)
	# 	end
	# end
	it "can set the current active customer" do
		@CustomerController= CustomerController.new
		@current_active_customer = @CustomerController.select_customer
		expect(@current_active_customer).to eq(1)
	end

	# it "can ask the user to set the current active customer again" do
	# 	@current_active_customer = @CustomerModel.select_customer(2)
	# 	expect(@current_active_customer).to eq('null')
	# end



end