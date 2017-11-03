require 'spec_helper'
require 'date'

describe CustomerModel do
	before(:each) do
		@customer_hash = {
			:customer_name => 'Yet Another Customer',
			:address => '333 Main St',
			:city => 'Nashville',
			:state => 'TN',
			:zip => 37206,
			:phone => '555-1212'
		}
		@customer_model = CustomerModel.new('./db/test.sqlite')
	end
	it 'should raise an error without arguments' do
		expect{@customer_model.add_customer}.to raise_error(ArgumentError)
	end
end

describe CustomerController do

	before(:all) do
		@CustomerController = CustomerController.new
		@name = 'Jeremy'
		@address = '333 Main St.'
		@city = 'Nashville'
		@state = 'TN'
		@zip = '37206'
		@phone = '555-1212'
	end

	it 'raises an error if the get_name input is blank' do
		expect{@CustomerController.get_name}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_name(@name)
		expect(@CustomerController.customer_hash[:customer_name]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_name(@name)
		expect(@CustomerController.customer_hash[:customer_name]).to eq(@name)
	end

	it 'raises an error if the get_address input is blank' do
		expect{@CustomerController.get_address}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_address(@address)
		expect(@CustomerController.customer_hash[:address]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_address(@address)
		expect(@CustomerController.customer_hash[:address]).to eq(@address)
	end

	it 'raises an error if the get_city input is blank' do
		expect{@CustomerController.get_city}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_city(@city)
		expect(@CustomerController.customer_hash[:city]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_city(@city)
		expect(@CustomerController.customer_hash[:city]).to eq(@city)
	end

	it 'raises an error if the get_state input is blank' do
		expect{@CustomerController.get_state}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_state(@state)
		expect(@CustomerController.customer_hash[:state]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_state(@state)
		expect(@CustomerController.customer_hash[:state]).to eq(@state)
	end

	it 'raises an error if the get_zip input is blank' do
		expect{@CustomerController.get_zip}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_zip(@zip)
		expect(@CustomerController.customer_hash[:zip]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_zip(@zip)
		expect(@CustomerController.customer_hash[:zip]).to eq(@zip)
	end

	it 'raises an error if the get_phone input is blank' do
		expect{@CustomerController.get_phone}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		@CustomerController.get_phone(@phone)
		expect(@CustomerController.customer_hash[:phone]).to be_a(String)
	end

	it 'expects argument to be added to the hash' do
		@CustomerController.get_phone(@phone)
		expect(@CustomerController.customer_hash[:phone]).to eq(@phone)
	end

end