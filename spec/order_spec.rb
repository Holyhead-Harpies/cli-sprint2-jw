require 'spec_helper'
describe OrderController do
	before(:each) do
		@order = OrderController.new
		@ordermodel = OrderModel.new
	end
	it "has a function to add a product to orders" do
		expect(@order).to respond_to(:addproduct).with(1).arguments
	end
	# it "can add product to orders" do
	# 	@order.addproduct(1)
	# end
	it "can show a list of products" do
		expect(@order).to respond_to(:showproducts)
	end

	context "@ordermodel.get_current_customer_open_orders(id)" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:get_current_customer_open_orders).with(1).arguments
		end

		it "returns the correct order" do
			# @customer = CustomerModel.new
			# customer_hash = {:customer_name => 'Ron Swanson', :address => '111 Main St.', :city => 'Nashville', :state => 'TN', :zip => '33333', :phone => '6155555555', :created_at => '11/03/2017', :updated_at => '11/03/2017'}
			# customer_id = @customer.add_customer(customer_hash)
			customer_id = 1
			expect(@ordermodel.get_current_customer_open_orders(customer_id)[0]).to include("CustomerId" => customer_id)
		end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.get_current_customer_open_orders}.to raise_error(ArgumentError)
		end

		it "raises an argument error with more than one argument given" do
			expect{@ordermodel.get_current_customer_open_orders("arg1", "arg2")}.to raise_error(ArgumentError)
		end
	end

	context "@order.get_all_products_from_order(customerId, orderId)" do
		it "takes a single argument" do
			expect(@order).to respond_to(:get_all_products_from_order).with(2).arguments
		end

		it "raises an argument error with 0 arguments given" do
			expect{@order.get_all_products_from_order}.to raise_error(ArgumentError)
		end

		it "raises an argument error with one argument given" do
			expect{@order.get_all_products_from_order("arg1")}.to raise_error(ArgumentError)
		end

		it "raises an argument error with more than two argument given" do
			expect{@order.get_all_products_from_order("arg1", "arg2", "arg3")}.to raise_error(ArgumentError)
		end
	end

	context "@ordermodel.get_all_products_from_order(id)" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:get_all_products_from_order).with(1).arguments
		end

		# it "returns the correct order" do
		# 	# @customer = CustomerModel.new
		# 	# customer_hash = {:customer_name => 'Ron Swanson', :address => '111 Main St.', :city => 'Nashville', :state => 'TN', :zip => '33333', :phone => '6155555555', :created_at => '11/03/2017', :updated_at => '11/03/2017'}
		# 	# customer_id = @customer.add_customer(customer_hash)
		# 	customer_id = 1
		# 	expect(@ordermodel.get_all_products_from_order(customer_id)[0]).to include("CustomerId" => customer_id)
		# end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.get_all_products_from_order}.to raise_error(ArgumentError)
		end

		it "raises an argument error with more than one argument given" do
			expect{@ordermodel.get_all_products_from_order("arg1", "arg2")}.to raise_error(ArgumentError)
		end
	end


end