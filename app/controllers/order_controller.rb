require 'text-table'
require './app/models/order_model.rb'
require './app/models/product_model.rb'

class OrderController

	def initialize
		@products_model = ProductModel.new
		@table = Text::Table.new
	end

	def create_new_order
		puts "Please select a product to add to the order:"
		show_products

		puts "Enter the ID number of the product you want to add"
		product_id = STDIN.gets.chomp

		select_product(product_id)
	end

	def show_products
		all_products = @products_model.show_all_products
		puts all_products.to_table
	end

	def select_product(product_id)

	end
end