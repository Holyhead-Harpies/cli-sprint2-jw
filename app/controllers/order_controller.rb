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
			sum = get_total_price_of_order(product_info.flatten)
			puts "Your order total is $#{sum}. Ready to purchase?"
			puts "(y/n)"
			if is_customer_ready_to_purchase?
				payment_types_current_customer = PaymentTypeModel.new.get_current_customer_payment_types(customerId)
				show_current_customer_payment_options(payment_types_current_customer)
				option = STDIN.gets.chomp.to_i
				payment_type_id = get_payment_type_id(option, payment_types_current_customer)
				OrderModel.new.add_payment_type_to_open_order(open_order[0][0], payment_type_id)
				OrderModel.new.set_order_status_completed_to_true(open_order[0][0])
			else 
				return
			end
			
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
		sum = 0
		products.each do |p|
			sum += p[2] * p[:number_on_order]
		end
		sum
	end


end