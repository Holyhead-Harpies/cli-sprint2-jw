require 'sqlite3'
class OrderModel

	def initialize
		@db = SQLite3::Database.open('./db/sprint2.sqlite')
		@db.results_as_hash = true
	end

	def showproducts

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