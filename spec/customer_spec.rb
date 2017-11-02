require 'spec_helper'
require 'date'

describe CustomerModel do
	before(:each) do
		@customer_hash = {
			:customer_name => 'Jeremy',
			:address => '333 Main St',
			:city => 'Nashville',
			:state => 'TN',
			:zip => 37206,
			:phone => '555-1212',
			:created_at => DateTime.now,
			:updated_at => DateTime.now
		}
		@customer_model = CustomerModel.new
	end
	it 'should raise an error without arguments' do
		expect{@customer_model.add_customer}.to raise_error(ArgumentError)
	end
	# it 'should raise an exception with a malformed hash' do
	# 	expect{@customer_model.add_customer({:customer_name => 'Jeremy'})}.to raise_error(SQLite3::Exception)
	# end
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
		expect(@CustomerController.get_name(@name)[:customer_name]).to be_a(String)
	end

	it 'raises an error if the get_address input is blank' do
		expect{@CustomerController.get_address}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		expect(@CustomerController.get_address(@address)[:address]).to be_a(String)
	end

	it 'raises an error if the get_city input is blank' do
		expect{@CustomerController.get_city}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		expect(@CustomerController.get_city(@city)[:city]).to be_a(String)
	end

	it 'raises an error if the get_state input is blank' do
		expect{@CustomerController.get_state}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		expect(@CustomerController.get_state(@state)[:state]).to be_a(String)
	end

	it 'raises an error if the get_zip input is blank' do
		expect{@CustomerController.get_zip}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		expect(@CustomerController.get_zip(@zip)[:zip]).to be_a(String)
	end

	it 'raises an error if the get_phone input is blank' do
		expect{@CustomerController.get_phone}.to raise_error(ArgumentError)
	end

	it 'expects input to be a string' do
		expect(@CustomerController.get_phone(@phone)[:phone]).to be_a(String)
	end

end