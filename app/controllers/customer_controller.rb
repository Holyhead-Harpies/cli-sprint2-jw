require_relative "../../app/models/customer_model"

class CustomerController

	def initialize
		@CustomerModel = CustomerModel.new
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

# customer = CustomerController.new
# p customer.show_all_customers
