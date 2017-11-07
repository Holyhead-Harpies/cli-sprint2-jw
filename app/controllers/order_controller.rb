require './app/models/order_model.rb'
require './app/models/product_model.rb'

class OrderController

	def initialize
		@products_model = ProductModel.new
		@order_model = OrderModel.new
		@shopping_cart = Array.new
	end

	  ## @brief      runs user interactions for adding a product to an open order
	  ## @param      none
	  ## @return     none
	def add_product_to_order
		@all_products = @products_model.show_all_products
		loop do
			puts "Please select a product to add to the order:"
			show_products

			puts "Enter the ID number of the product you want to add, or type 'L' to leave."
			selection = STDIN.gets.chomp

			select_product(selection)

			break if selection.downcase == 'l'
		end
	end

	  ## @brief      displays all products in the database, shows id# and title
	  ## @param      none
	  ## @return     none
	def show_products
		@all_products.each do |item|
			puts "#{item["ProductId"]} #{item["Title"]}"
		end
	end

	  ## @brief      adds a new product to the OrdersProducts table in the database
	  ## @param      order id (of open order) and id of selected product
	  ## @return     none
	def select_product(order_id, product_id)
		if  product_id.downcase != 'l'
			@order_model.add_product_to_order(order_id, product_id)
			selected_product =  @products_model.show_one_product(product_id)
			@shopping_cart.push(selected_product[0])

			puts "Your shopping cart contains:"
			puts '*******************************************'
			@shopping_cart.each do |item|
				puts "#{item['ProductId']} #{item['Title']}"
			end
			puts '*******************************************'
		end
	end
end