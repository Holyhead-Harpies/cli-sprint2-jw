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

	def get_current_customer_closed_orders(customerId)
		order = @db.execute("select o.* from Orders o where o.CustomerId = '#{customerId}' and o.Completed = '1'")
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