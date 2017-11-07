require './app/models/order_model.rb'
require './app/models/product_model.rb'

class OrderController

	def initialize
		@products_model = ProductModel.new('./db/test.sqlite')
	end

	def create_new_order
		@all_products = @products_model.show_all_products
		loop do
			puts "Please select a product to add to the order:"
			show_products

			puts "Enter the ID number of the product you want to add, or type 'L' to leave."
			selection = STDIN.gets.chomp

			select_product(selection)

			puts all_products

			break if selection.downcase == 'l'
		end
	end

	def show_products
		@all_products.each do |item|
			puts "#{item["ProductId"]} #{item["Title"]}"
		end
	end

	def select_product(product_id)
		if product_id.is_a? Integer || product_id.downcase != 'l'
			selected_product =  @products_model.show_one_product(product_id)
			selected_product
		end
	end
end