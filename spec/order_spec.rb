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
end