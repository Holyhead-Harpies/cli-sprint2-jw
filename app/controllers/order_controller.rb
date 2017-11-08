require_relative '../models/order_model.rb'
require_relative '../models/product_model.rb'
require_relative '../models/payment_types_model.rb'

##
## @brief      Controls the data flow from OrderModel to Menu
##
class OrderController

	##
	## @brief      initializes ProductModel OrderModel and shopping cart
	##
	## @return
	##
	def initialize
		@products_model = ProductModel.new
		@order_model = OrderModel.new
		@shopping_cart = Array.new
	end

	## @brief      runs user interactions for adding a product to an open order
	## @param      none
	## @return     none
	def add_product_to_order(active_customer)
		@all_products = @products_model.show_all_products
		@order_id = @order_model.get_current_customer_open_orders(active_customer)
		if @order_id == []
			@order_id = create_new_order(active_customer)
		end

		loop do
			puts "Please select a product to add to the order:"
			show_products

			puts "Enter the ID number of the product you want to add, or type 'L' to leave."
			selection = STDIN.gets.chomp

			select_product(@order_id, selection)

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
			p order_id
			p product_id
			@order_model.add_product_to_order(order_id[0][0], product_id.to_i)
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


	## @brief      creates a new order in the Orders table
	## param	   the id of the active customer
	## @return     the id of the order created
	def create_new_order(customer_id)
		@order_model.create_new_order(customer_id)
	end

	##
	## @brief      completes a customer's order
	##
	## @param      customerId  The customer identifier
	##
	## @return     to main menu
	##
	def complete_current_customer_open_order(customerId)
		open_order = OrderModel.new.get_current_customer_open_orders(customerId)
        if open_order == []
            puts "Please add some products to your order first. Press any key to return to main menu."
            STDIN.gets.chomp
		else
			all_products_on_order = OrderModel.new.get_all_products_from_order(open_order[0][0])
			p all_products_on_order
			product_info = Array.new
			all_products_on_order.each_with_index do |p, i|
				product_info << ProductModel.new.get_product_price_info(p[0])
				p product_info
				product_info[i][0][:number_on_order] = all_products_on_order[i][1]
			end
			product_info = product_info.flatten
			quantities_available = Array.new
			wanted_quantities = Array.new
			product_info.each do |p|
				quantity_available = ProductModel.new.get_quantity(p)
				quantities_available << quantity_available[0][0]
				wanted_quantities << p[:number_on_order]
			end
			less_than_available = false
			quantities_available.length.times do |q|
				if quantities_available[q] - wanted_quantities[q] < 0
					less_than_available = true
				end
			end
			if less_than_available
				puts "Not enough quantity available for one or more of the products on your order."
			else
				sum = get_total_price_of_order(product_info)
				puts "Your order total is $#{sum}. Ready to purchase?"
				puts "(y/n)"
				if is_customer_ready_to_purchase?
					payment_types_current_customer = PaymentTypeModel.new.get_current_customer_payment_types(customerId)
					show_current_customer_payment_options(payment_types_current_customer)
					puts "Select a payment option."
					option = STDIN.gets.chomp.to_i
					payment_type_id = get_payment_type_id(option, payment_types_current_customer)
					OrderModel.new.add_payment_type_to_open_order(open_order[0][0], payment_type_id)
					OrderModel.new.set_order_status_completed_to_true(open_order[0][0])
					reduce_products_quantity(product_info)
				else
					return
				end
			end
        end
	end

	##
	## @brief      reduces the quantity of a product
	##
	## @param      products  The products
	##
	## @return
	##
	def reduce_products_quantity(products)
		products.each do |p|
			ProductModel.new.reduce_quantity(p)
		end
	end

	##
	## @brief      Gets the payment type identifier.
	##
	## @param      option         The option
	## @param      payment_types  The payment types
	##
	## @return     The payment type identifier.
	##
	def get_payment_type_id(option, payment_types)
		payment_types[option-1][0]
	end

	##
	## @brief      Determines if customer ready to purchase.
	##
	## @return     True if customer ready to purchase, False otherwise.
	##
	def is_customer_ready_to_purchase?
		option = STDIN.gets.chomp.downcase
		case option
		when 'y'
			true
		when 'n'
			false
		else
			puts "Input not recognized. Please try again."
			is_customer_ready_to_purchase?
		end
	end

	##
	## @brief      Shows the current customer payment options.
	##
	## @param      payment_types  The payment types
	##
	## @return     the payment type options for the customer to select
	##
	def show_current_customer_payment_options(payment_types)

		payment_types.each_with_index do |p, i|
			puts "#{i+1}. #{p[2]}"
		end

	end

	##
	## @brief      Gets the total price of order.
	##
	## @param      products  The products
	##
	## @return     The total price of order.
	##
	def get_total_price_of_order(products)
		p products
		sum = 0
		products.each do |p|
			sum += p[2] * p[:number_on_order]
		end
		sum
	end


end