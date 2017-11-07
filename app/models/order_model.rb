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
		order = @db.execute("select o.* from Orders o where o.CustomerId = '#{customerId}' and o.Completed = '0'")
		@db.close
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
end