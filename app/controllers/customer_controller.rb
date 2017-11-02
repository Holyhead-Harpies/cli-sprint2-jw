require_relative '../models/customer_model'
require 'date'

class CustomerController

	attr_accessor :customer_hash

	def initialize(customer_hash = Hash.new)
		@customer_hash = customer_hash
		@customer_hash[:created_at] = Date.new
		@customer_hash[:updated_at] = Date.new
	end

	def create_new_customer
		puts "Enter the customer's name"
		customer_name = STDIN.gets.chomp
		get_name(customer_name)

		puts "Enter the customer's address"
		address = STDIN.gets.chomp
		get_address(address)

		puts "Enter the customer's name"
		city = STDIN.gets.chomp
		get_city(city)

		puts "Enter the customer's name"
		state = STDIN.gets.chomp
		get_state(state)

		puts "Enter the customer's name"
		zip = STDIN.gets.chomp
		get_zip(zip)
	end

	def get_name(customer_name)
		@customer_hash[:customer_name] = customer_name
		@customer_hash
	end

	def get_address(address)
		@customer_hash[:address] = address
		@customer_hash
	end

	def get_city(city)
		@customer_hash[:city] = city
		@customer_hash
	end

	def get_state(state)
		@customer_hash[:state] = state
		@customer_hash
	end

	def get_zip(zip)
		@customer_hash[:zip] = zip.to_s
		@customer_hash
	end

	def get_phone(phone)
		@customer_hash[:phone] = phone
		@customer_hash
	end
end