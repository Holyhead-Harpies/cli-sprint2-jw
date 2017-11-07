require 'sqlite3'

##
## @brief      Class for Customer Model.
##

class CustomerModel
## @brief      initializes the database for the model to write to
## @param      directory path to the database, default is sprint2.db
## @return     no value returned
	def initialize(database = './db/sprint2.sqlite')
		@db = SQLite3::Database.new(database)
		@db.results_as_hash = true
	end
## @brief      adds customer data to the database, customer table
## @param      customer hash
## @return     returns row id when customer is successfully added
	def add_customer(customer_hash)
		begin
			statement = "INSERT INTO Customers(Name, Street_Address, City, State, ZIP, Phone, created_at, updated_at) VALUES('#{customer_hash[:customer_name]}', '#{customer_hash[:address]}', '#{customer_hash[:city]}', '#{customer_hash[:state]}', '#{customer_hash[:zip]}', '#{customer_hash[:phone]}', '#{customer_hash[:created_at]}', '#{customer_hash[:updated_at]}')"
			@db.transaction
			@db.execute statement
			@db.commit
			puts "Customer was created successully"
			@db.last_insert_row_id
		rescue SQLite3::Exception => e
			puts "Exception occurred while adding the customer"
			puts e
			@db.rollback
		ensure
			@db.close
		end
	end

	def get_all_customers
		stm = @db.execute "select * from Customers"
	end

	def get_unique_customers(product)
		queried_product = @db.execute("select p.ProductId, count(distinct c.CustomerId) 'Num Orders' from Orders o, Products p, OrdersProducts op, Customers c where o.Completed = '1' and o.OrderId = op.OrderId and op.ProductId = p.ProductId and o.CustomerId = c.CustomerId and p.ProductId = #{product[0]} group by op.ProductId")
		@db.close
		return queried_product[0][1]
	end
end
