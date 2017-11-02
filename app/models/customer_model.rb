require 'sqlite3'

class CustomerModel

	def initialize
		@db = SQLite3::Database.new('./db/test.sqlite')
		@db.results_as_hash = true
	end

	def add_customer(customer_hash)
		begin
			statement = "INSERT INTO Customers(Name, Street_Address, City, State, ZIP, Phone, created_at, updated_at) VALUES('#{customer_hash[:customer_name]}', '#{customer_hash[:address]}', '#{customer_hash[:city]}', '#{customer_hash[:state]}', '#{customer_hash[:zip]}', '#{customer_hash[:phone]}', '#{customer_hash[:created_at]}', '#{customer_hash[:updated_at]}')"
			@db.transaction
			@db.execute statement
			@db.commit
		rescue SQLite3::Exception => e
			puts "Exception occurred from CustomerModel.add_customer"
			puts e
			@db.rollback
		ensure
			@db.close
		end
	end
end