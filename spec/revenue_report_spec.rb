describe OrderModel do
	before(:each) do
		@OrderModel = OrderModel.new
		@OrderController = OrderController.new
		@Product = Product.new
	end
	it "has a method to show all customers" do
		expect(@OrderController).to respond_to(:show_revenue)
	end

	it "gets the ids of completed orders of the customer" do
		closed_order_id = @OrderModel.get_current_customer_closed_orders(1)
		expect(closed_order_id.length).to eq(2)
	end
	it "gets the products of completed orders" do
		products = @OrderModel.get_all_products_from_order(2)
		expect(products[0]['NumberProducts']).to eq(1)
	end
	it "gets the price of specific product" do
		productid = @OrderModel.get_all_products_from_order(2)[0]['ProductId']
		price = @Product.get_product_price_info(productid)[0]['Price']
		expect(price).to eq(1)
	end

	it "prints revenue information for a specific customer" do
		@OrderController.show_revenue(1)
	end

	# context "user selects a customer" do
	# 	before(:each) do
	# 		@CustomerModel = CustomerModel.new
	# 		@CustomerController = CustomerController.new
	# 	end

	# 	it "should set the current customer if it is an existing customer" do
	# 		@customers = @CustomerModel.get_all_customers
	# 		@current_active_customer = @CustomerController.set_customer(2,@customers)
	# 		expect(@current_active_customer).to eq(2)
	# 	end

	# 	it "should display 'Customer Does Not Exist' if it is a non-existent customer" do
	# 		@customers = @CustomerModel.get_all_customers
	# 		@current_active_customer = @CustomerController.set_customer(0,@customers)
	# 		expect(@current_active_customer).to eq('Customer Does Not Exist')
	# 	end
	# end
end
