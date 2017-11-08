require 'spec_helper'
describe OrderController do
	before(:each) do
		@order_controller = OrderController.new
		@ordermodel = OrderModel.new('../db/test.sqlite')
	end

	context 'A new order is created' do

		it 'has a function to create a new order' do
			# @order_controller.create_new_order
			expect(@order_controller).to respond_to(:add_product_to_order)
		end

	end


	it 'can show a list of products' do
		expect(@order_controller).to respond_to(:show_products)
	end

	it 'has a method to select a product' do
		expect(@order_controller).to respond_to(:select_product).with(2).arguments
	end

	context 'A new order is saved to the database...' do

		it 'has a method to add product to order' do
			expect(@ordermodel).to respond_to(:add_product_to_order)
		end

		it 'raises an error unless it has two arguments' do
			expect{@ordermodel.add_product_to_order}.to raise_error(ArgumentError)
			expect{@ordermodel.add_product_to_order('one arg')}.to raise_error(ArgumentError)
		end

	end

	it "can show a list of products" do
		expect(@order_controller).to respond_to(:show_products)
	end

	context "@ordermodel.get_current_customer_open_orders(id)" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:get_current_customer_open_orders).with(1).arguments
		end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.get_current_customer_open_orders}.to raise_error(ArgumentError)
		end

		it "raises an argument error with more than one argument given" do
			expect{@ordermodel.get_current_customer_open_orders("arg1", "arg2")}.to raise_error(ArgumentError)
		end
	end

	context "@ordermodel.get_all_products_from_order(customerId, orderId)" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:get_all_products_from_order).with(1).arguments
		end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.get_all_products_from_order}.to raise_error(ArgumentError)
		end

		it "raises an argument error with one argument given" do
			expect{@ordermodel.get_all_products_from_order("arg1", "arg2")}.to raise_error(ArgumentError)
		end

	end

	context "@ordermodel.get_all_products_from_order(id)" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:get_all_products_from_order).with(1).arguments
		end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.get_all_products_from_order}.to raise_error(ArgumentError)
		end

		it "raises an argument error with more than one argument given" do
			expect{@ordermodel.get_all_products_from_order("arg1", "arg2")}.to raise_error(ArgumentError)
		end
	end

	context "@ordermodel.add_payment_type_to_open_order" do
		it "takes a single argument" do
			expect(@ordermodel).to respond_to(:add_payment_type_to_open_order).with(2).arguments
		end

		it "raises an argument error with 0 arguments given" do
			expect{@ordermodel.add_payment_type_to_open_order}.to raise_error(ArgumentError)
		end

		it "raises an argument error with one argument given" do
			expect{@ordermodel.add_payment_type_to_open_order("arg1")}.to raise_error(ArgumentError)
		end
	end

	context "@order.get_payment_type_id" do
		it "takes two arguments" do
			expect(@order_controller).to respond_to(:get_payment_type_id).with(2).arguments
		end

		it "gets the correct payment type based on customer input" do
			option = 1
			payment_types = [{0 => 1}]
			expect(@order_controller.get_payment_type_id(option, payment_types)).to eq(payment_types[option - 1][0])
		end
	end

	context "@order.get_total_price_of_order" do
		it "returns correct sum" do
			products = [{2 => 5, :number_on_order => 2}, {2 => 5, :number_on_order => 1}]
			expect(@order_controller.get_total_price_of_order(products)).to eq(15)
		end
	end

	context 'the user is creating a new order' do
		it 'has a method create_new_order' do
			expect(@order_controller).to respond_to(:create_new_order)
		end

		it 'raises an argument error if no argument is given' do
			expect{@order_controller.create_new_order}.to raise_error(ArgumentError)
		end

		it 'returns an integer if a new order is created' do
			expect(@order_controller.create_new_order(5)).to be_a(Integer)
		end

		it '@order_model has a method for creating a new order' do
			expect(@ordermodel).to respond_to(:create_new_order)
		end
	end

end