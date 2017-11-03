require 'text-table'
require './app/models/order_model.rb'
require './app/models/product_model.rb'

class OrderController

	def initialize
		@products_model = ProductModel.new
		@table = Text::Table.new
	end

	def show_products
		all_products = @products_model.show_all_products
		puts all_products.to_table
	end
	def addproduct(product)

	end
end