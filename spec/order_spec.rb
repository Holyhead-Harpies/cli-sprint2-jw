require 'spec_helper'
describe OrderController do
	before(:each) do
		@order_controller = OrderController.new
		@ordermodel = OrderModel.new
	end

	context 'A new order is created' do

		it 'has a function to create a new order' do
			@order_controller.create_new_order
			expect(@order_controller).to respond_to(:create_new_order)
		end

	end

	it 'can show a list of products' do
		expect(@order_controller).to respond_to(:show_products)
	end

	it 'has a function to select a product' do
		expect(@order_controller).to respond_to(:select_product).with(1).arguments
	end

	# it 'returns the product that was selected' do
	# 	expect(@order_controller.select_product(3)[0][0]).to eq(3)
	# end

end