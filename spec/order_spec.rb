require 'spec_helper'
describe OrderController do
	before(:each) do
		@order = OrderController.new
		@ordermodel = OrderModel.new
	end

	context 'A new order is created' do

		it 'has a function to create a new order' do
			@order.create_new_order
			expect(@order).to respond_to(:create_new_order)
		end

	end

	it "can show a list of products" do
		expect(@order).to respond_to(:show_products)
	end

	it "has a function to add a product to orders" do
		expect(@order).to respond_to(:select_product).with(1).arguments
	end

end