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
end