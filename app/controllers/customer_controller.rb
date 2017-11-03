require './app/models/customer_model.rb'

class CustomerController
	def initialize
		@CustomerModel = CustomerModel.new
	end
	def select_customer
		puts "Which Customer Will Be Active?"
		customerid = STDIN.gets.chomp
		@CustomerModel.select_customer(customerid)
	end
end