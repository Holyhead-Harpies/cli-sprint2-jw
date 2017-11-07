require 'spec_helper'
describe OrderController do
	before(:each) do
		@order_controller = OrderController.new
		@ordermodel = OrderModel.new('./db/test.sqlite')
	end

	context 'A new order is created' do

		it 'has a function to create a new order' do
			# @order_controller.create_new_order
			expect(@order_controller).to respond_to(:create_new_order)
		end

	end

	it 'can show a list of products' do
		expect(@order_controller).to respond_to(:show_products)
	end

	it 'has a method to select a product' do
		expect(@order_controller).to respond_to(:select_product).with(1).arguments
	end

	context 'A new order is saved to the database...' do

		it 'has a method to add product to order' do
			expect(@ordermodel).to respond_to(:add_product_to_order)
		end

		it 'raises an error unless it has two arguments' do
			expect{@ordermodel.add_product_to_order}.to raise_error(ArgumentError)
			expect{@ordermodel.add_product_to_order('one arg')}.to raise_error(ArgumentError)
		end

		it 'writes something to the database' do
			@ordermodel.add_product_to_order(3, 5)
		end

	end

end