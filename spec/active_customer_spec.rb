require 'spec_helper'

describe CustomerController do

	it "can show all customers" do
		@CustomerModel= CustomerModel.new
		expect(@CustomerModel).to respond_to(:get_all_customers)
	end

	it "shows all customers if it's called without arguments" do
		@CustomerModel= CustomerModel.new
		expect(@CustomerModel).to respond_to(:get_all_customers)
		expect{@CustomerModel.get_all_customers(1)}.to raise_error(ArgumentError)
	end

	context "user selects a customer" do
		before(:each) do
			@CustomerModel = CustomerModel.new
			@CustomerController = CustomerController.new
		end

		it "should set the current customer if it is an existing customer" do
			@customers = @CustomerModel.get_all_customers
			@current_active_customer = @CustomerController.set_customer(2,@customers)
			expect(@current_active_customer).to eq(2)
		end

		it "should display 'Customer Does Not Exist' if it is a non-existent customer" do
			@customers = @CustomerModel.get_all_customers
			@current_active_customer = @CustomerController.set_customer(0,@customers)
			expect(@current_active_customer).to eq('Customer Does Not Exist')
		end
	end





end