require_relative '../models/customer_model'
require 'date'

##
## @brief      Class for Customer Controller.
##

class CustomerController

	attr_accessor :customer_hash

## @brief      initializes the class with a new  CustomerModel, a Customer Hash, and a Date object
##
## @param      customer_hash, holds customer data to be entered to the db
##
## @return     does not return any values
##
	def initialize(customer_hash = Hash.new)
		@CustomerModel = CustomerModel.new
		d = DateTime.now
		date = "#{d.month}/#{d.day}#{d.year}"
		@customer_hash = customer_hash
		@customer_hash[:created_at] = date
		@customer_hash[:updated_at] = date
	end
## @brief      provides a series of prompts to the CLI to get customer data from the user
##
## @param      none
##
## @return     returns the table id of the added customer from the Customer Model
##
	def create_new_customer
		puts "Enter the customer's name"
		customer_name = STDIN.gets.chomp
		get_name(customer_name)

		puts "Enter the customer's address"
		address = STDIN.gets.chomp
		get_address(address)

		puts "Enter the customer's city"
		city = STDIN.gets.chomp
		get_city(city)

		puts "Enter the customer's state"
		state = STDIN.gets.chomp
		get_state(state)

		puts "Enter the customer's zip"
		zip = STDIN.gets.chomp
		get_zip(zip)

		puts "Enter the customer's phone number"
		phone = STDIN.gets.chomp
		get_phone(phone)

		@CustomerModel.add_customer(@customer_hash)
	end
## @brief      adds customer name to the customer_hash
## @param      customer name entered from the command line
## @return     no value returned
	def get_name(customer_name)
		@customer_hash[:customer_name] = customer_name
	end
## @brief      adds customer address to the customer_hash
## @param      customer address entered from the command line
## @return     no value returned
	def get_address(address)
		@customer_hash[:address] = address
	end
## @brief      adds customer city to the customer_hash
## @param      customer city entered from the command line
##@ return     no value returned
	def get_city(city)
		@customer_hash[:city] = city
	end
## @brief      adds customer state to the customer_hash
## @param      customer state entered from the command line
## @ return     no value returned
	def get_state(state)
		@customer_hash[:state] = state
	end
## @brief      adds customer city to the customer_hash
## @param      customer city entered from the command line
## @ return      no value returned
	def get_zip(zip)
		@customer_hash[:zip] = zip.to_s
	end
## @brief      adds customer phone to the customer_hash
## @param      customer phone entered from the command line
##@ return      no value returned
	def get_phone(phone)
		@customer_hash[:phone] = phone
	end

	def show_all_customers
		@customers = @CustomerModel.get_all_customers
		@customers.each_with_index do |customer,index|
			p "#{index+1}: #{customer['Name']}"
		end
		select_customer(@customers)
	end

	def select_customer(customers)
		puts "Which Customer Will Be Active?"
		customerid = STDIN.gets.chomp
		set_customer(customerid,customers)
	end

	def set_customer(cid,customers)
		if cid =~ /[^1-9]/ || cid < 1 || cid > customers.length
			puts 'Customer Does Not Exist'
			'Customer Does Not Exist'
		else
			cid
		end
	end

end