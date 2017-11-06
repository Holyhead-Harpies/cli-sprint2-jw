require 'spec_helper'

describe Product do
	before(:each) do
		@Product = Product.new
		@ProductController = ProductController.new

	end
	it "has a method to update a customer's product" do
		expect(@Product).to respond_to(:update_product)
	end

	it "has a method to retrieve a single product" do
		expect(@ProductController).to respond_to(:show_product)
	end
	# it "shows a list of the product's values that can be changed" do
	# 	expect(@ProductController.show_product(1,1)[0]['Title']).to eq('Fang')
	# end
	it "can update with 4 arguments" do
		expect(@Product).to respond_to(:update_product).with(4).arguments
	end
	it "throws an ArgumentError if update is called without 4 arguments" do
		expect{@Product.update_product(1,2,3)}.to raise_error(ArgumentError)
	end

	it "can update a customer's product" do
		Product.new.update_product(2,2,'Price',"Bryon")
		updated_product = @Product.get_product(2,2)

		expect(updated_product[0]['Title']).to eq('Bryon')
	end




end