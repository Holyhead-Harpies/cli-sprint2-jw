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
		@all_products = show_products

		puts "Enter the ID number of the product you want to add"
		product_id = STDIN.gets.chomp

		selected_product = select_product(product_id)
		remove_product_from_list(product_id, @all_products)

		puts "Your product has been added to your shopping cart"
		puts "Enter the ID number of the product you want to add, or type 'Done' to leave"
	end

	def show_products
		all_products = @products_model.show_all_products
		puts all_products.to_table
		all_products
	end

	def select_product(product_id)
		selected_product =  @products_model.show_one_product(product_id)
		puts selected_product.to_table
		p selected_product
		selected_product
	end

	def remove_product_from_list(product_id, product_list)
		
	end
end