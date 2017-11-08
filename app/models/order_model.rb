require 'sqlite3'
require 'date'

class OrderModel

	def initialize(database = './db/sprint2.sqlite')
		@database = database
	end

  ## @brief      opens a connection to the database specified when class is initialized
  ## @param      none
  ## @return     returns connection to database
	def open_db_connection
		SQLite3::Database.open(@database)
	end

	## @brief      creates a new order in the database
	## param		the id of the active customer
	## return 		the id of the order created
	def create_new_order(customer_id)
		d = DateTime.now
		date = "#{d.month}/#{d.day}/#{d.year}"
		@db = open_db_connection
		begin
			statement = "INSERT INTO Orders (CustomerId, PaymentTypeId, Completed, created_at, updated_at) VALUES('#{customer_id}', '0', '0', '#{date}', '#{date}')"
		    @db.transaction
		    @db.execute statement
		    @db.commit
		    order_id = @db.last_insert_row_id
		rescue SQLite3::Exception => e
		    puts 'Exception occurred from OrderModel.add_product_to_order'
		    puts e
		    @db.rollback
		ensure
			@db.close
		end
		return order_id
	end

  ## @brief      adds an order id associated with a product id to the OrdersProducts table in the db
  ## @param      order id and product id
  ## @return     none
	def add_product_to_order(order_id, product_id)
		d = DateTime.now
		date = "#{d.month}/#{d.day}/#{d.year}"
		@db = open_db_connection
		begin
			statement = "INSERT INTO OrdersProducts(OrderId, ProductId, created_at, updated_at)
						VALUES('#{order_id}', '#{product_id}', '#{date}', '#{date}')"
		    @db.results_as_hash = true
		    @db.transaction
		    @db.execute statement
		    @db.commit
		rescue SQLite3::Exception => e
		    puts 'Exception occurred from OrderModel.add_product_to_order'
		    puts e
		    @db.rollback
		ensure
			@db.close
		end
	end

	def get_current_customer_open_orders(customerId)
		@db = open_db_connection
		order = @db.execute("select o.* from Orders o where o.CustomerId = '#{customerId}' and o.Completed = '0'")
		@db.close
		puts "get_current_customer_open_orders output is #{order} "
		return order
	end

	def get_all_products_from_order(orderId)
		products_on_order = @db.execute("select op.ProductId, count(*) 'NumberProducts' from OrdersProducts op where op.OrderId = #{orderId} group by op.ProductId")
		@db.close
		return products_on_order
	end

	def add_payment_type_to_open_order(order_id, payment_type_id)
		@db.execute("update Orders set PaymentTypeId = #{payment_type_id} where OrderId = #{order_id}")
		@db.close
	end

	def set_order_status_completed_to_true(order_id)
		@db.execute("update Orders set Completed = 1 where OrderId = #{order_id}")
		@db.close
	end

	def get_all_products_on_closed_orders
		closed_orders = @db.execute("select p.ProductId, p.Title, p.Price, count(*) 'Number Sold' from Orders o, Products p, OrdersProducts op  where o.Completed = '1' and o.OrderId = op.OrderId and p.ProductId = op.ProductId group by op.ProductId")
		@db.close
		return closed_orders
	end

	def get_unique_orders(product)
		order_query = @db.execute("select p.ProductId, count(distinct op.OrderId) 'Num Orders' from Orders o, Products p, OrdersProducts op  where o.Completed = '1' and o.OrderId = op.OrderId and op.ProductId = p.ProductId and op.ProductId = #{product[0]} group by op.ProductId")
		@db.close
		return order_query[0][1]
	end
end