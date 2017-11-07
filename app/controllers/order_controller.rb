require './app/models/order_model.rb'
require './app/models/product_model.rb'
require './app/models/payment_types_model.rb'

class OrderController

	def initiallize

	end

	def addproduct(product)

	end

	def showproducts

	end

	def complete_current_customer_open_order(customerId)
		open_order = OrderModel.new.get_current_customer_open_orders(customerId)
        if open_order == []
            puts "Please add some products to your order first. Press any key to return to main menu."
            STDIN.gets.chomp
		else
			all_products_on_order = OrderModel.new.get_all_products_from_order(open_order[0][0])
			product_info = Array.new
			all_products_on_order.each_with_index do |p, i|	
				product_info << Product.new.get_product_price_info(p[0])
				product_info[i][0][:number_on_order] = all_products_on_order[i][1]
			end
			product_info = product_info.flatten
			quantities_available = Array.new
			wanted_quantities = Array.new
			product_info.each do |p|
				quantity_available = Product.new.get_quantity(p)
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

	def reduce_products_quantity(products)
		products.each do |p|
			Product.new.reduce_quantity(p)
		end
	end

	def get_payment_type_id(option, payment_types)
		payment_types[option-1][0]
	end

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

	def show_current_customer_payment_options(payment_types)

		payment_types.each_with_index do |p, i|
			puts "#{i+1}. #{p[2]}"
		end

	end

	def get_total_price_of_order(products)
		p products
		sum = 0
		products.each do |p|
			sum += p[2] * p[:number_on_order]
		end
		sum
	end


end