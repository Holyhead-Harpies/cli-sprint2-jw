require_relative '../models/product_model'
require './app/models/order_model.rb'
require './app/models/customer_model.rb'

##
## @brief      Class for Product Controller. Initalized with a
#               new Hash
##
class ProductController
  attr_accessor :product_hash

  def initialize(product_hash = Hash.new)
    @product_hash = product_hash
  end

  ## @brief      Adds customer_id to product_hash
  ##
  ## @param      customer_id
  ##
  ## @return
  ##

  def add_customer_id(customerId)
    @product_hash[:customer_id] = customerId
  end

  ## @brief      Adds title to product_hash
  ##
  ## @param      title
  ##
  ## @return
  ##

  def get_title(title)
    @product_hash[:title] = title.to_s
  end

  ## @brief      Adds description to product_hash
  ##
  ## @param      description
  ##
  ## @return
  ##

  def get_description(description)
    @product_hash[:description] = description.to_s
  end

  ## @brief      Adds price to product_hash
  ##
  ## @param      price
  ##
  ## @return
  ##

  def get_price(price)
    @product_hash[:price] = price.to_s
  end

  ## @brief      Adds quantity to product_hash
  ##
  ## @param      quantity
  ##
  ## @return
  ##

  def get_quantity(quantity)
    @product_hash[:quantity] = quantity.to_s
  end

  ## @brief      Captures users input and calls other Procuct Controller method
  ##
  ## @param      customerId
  ##
  ## @return     New Product model passing it the recently updated product_hash
  ##

  def create_product(customerId)
    add_customer_id(customerId)
    puts 'Enter Product TITLE: '
    title = STDIN.gets.chomp
    get_title(title)
    puts 'Enter Product DESCRIPTION: '
    description = STDIN.gets.chomp
    get_description(description)
    puts 'Enter Product PRICE: '
    price = STDIN.gets.chomp
    get_price(price)
    puts 'Enter Product QUANTITY: '
    quantity = STDIN.gets.chomp
    get_quantity(quantity)
    ProductModel.new.create_new_product(@product_hash)
  end

## @brief      Gets produts from model and prints to the console
  ##
  ## @param      customerId
  ##
  ## @return    Returns a list of products
  ##

  def show_products(customerId)
    products = ProductModel.new.get_products(customerId)
    products.each_with_index  do |p, i|
      p "#{i+1}. #{p['Title']}"
    end
    products
  end

  ## @brief      Remove products from model and prints to the console
  ##
  ## @param      customerId
  ##
  ## @return    nothing
  ##

  def remove_product(customerId)
    puts 'Select a product: '
    products = show_products(customerId)
    user_input = STDIN.gets.chomp.to_i
    if user_input.is_a?(Integer) && user_input.to_i <= products.length
      product_id = products[user_input-1]['ProductId']


      order_this_product_is_on = ProductModel.new.find_orders_with_product(product_id.to_i)
      on_open_order = false

      order_this_product_is_on.each do |o|
        status = OrderModel.new.check_for_open_order(o[0])
        if status == true
          on_open_order = true
        end
      end

      if on_open_order
        puts "This product is on an active order and cannot be removed."
      else
        ProductModel.new.remove_product(product_id.to_i)
      end
      return true
    else
      p "Not an option!"
      return
    end
  end


  ##
  ## @brief      Shows a single product of a customer to edit
  ##
  ## @param      customerId  The customer identifier
  ## @param      productId   The product identifier
  ##
  ## @return     returns the single product
  ##
  def show_product(customerId,productId)
    product = ProductModel.new.get_product(customerId,productId)
    puts "1. Change Title '#{product[0][0]}'"
    puts "2. Change Description '#{product[0][1]}'"
    puts "3. Change Price '#{product[0][2]}'"
    puts "4. Change Quantity '#{product[0][3]}'"
    return product
  end


  ##
  ## @brief      updates a single value of a product
  ##
  ## @param      customerId  The customer identifier
  ##
  ## @return     nothing
  ##
  def update_product(customerId)
    puts 'Select a product: '
    products = show_products(customerId)
    user_input = STDIN.gets.chomp.to_i
    if user_input.is_a?(Integer) && user_input.to_i <= products.length
      product_id = products[user_input-1]['ProductId']
      show_product(customerId,product_id)

      field_change = STDIN.gets.chomp
      case field_change
      when '1'
        field_change = 'Title'

        puts "Enter new Title"

      when '2'
        field_change = 'Description'

        puts "Enter new Description"

      when '3'
        field_change = 'Price'

        puts "Enter new Price"

      when '4'
        field_change = 'Quantity'

        puts "Enter new Quantity"
      else
        puts "Not a valid option!"
        return
      end


      value_change = STDIN.gets.chomp

      ProductModel.new.update_product(customerId,product_id,field_change,value_change)
    else
      p "Not an option!"
      return
    end

    
  end

  def show_popular_products(customerId)

    closed_orders = OrderModel.new.get_all_products_on_closed_orders
    products_with_total_revenue = Array.new
    closed_orders.each do |o|
      o[:total_revenue] = o[2] * o[3]
      products_with_total_revenue << o
    end

    products_with_total_revenue.sort!{ |a,b| b[:total_revenue]<=> a[:total_revenue]}

    top_three_sellers = products_with_total_revenue.slice(0, 3)

    top_three_sellers.each_with_index do |p, i|
      top_three_sellers[i][:number_orders] = OrderModel.new.get_unique_orders(p)
      top_three_sellers[i][:number_customers] = CustomerModel.new.get_unique_customers(p)
    end

    print_products(top_three_sellers)

  end


  def print_products(products)
    total_orders = (products[0][:number_orders] + products[1][:number_orders] + products[2][:number_orders]).to_s.split('')
    total_customers = (products[0][:number_customers] + products[1][:number_customers] + products[2][:number_customers]).to_s.split('')
    total_revenue = (products[0][:total_revenue] + products[1][:total_revenue] + products[2][:total_revenue]).round(2).to_s.split('')

    puts "Product             Orders     Purchasers     Revenue        "
    puts "*************************************************************"

    products.each do |p|
      name_split = p[1].split('')
      orders_split = p[:number_orders].to_s.split('')
      customers_split = p[:number_customers].to_s.split('')
      revenue_split = p[:total_revenue].to_s.split('')

      if name_split.length > 18
        new_name = name_split.slice(0,18)
        2.times {|l| new_name << "."}
        print new_name.join('')
      else
        spaces = 20 - name_split.length
        spaces.times { |s| name_split << " "}
        print name_split.join('')
      end 

      orders_spaces = 11 - orders_split.length
      orders_spaces.times { |o| orders_split << " " }
      print orders_split.join('')

      customers_spaces = 15 - customers_split.length
      customers_spaces.times { |o| customers_split << " " }
      print customers_split.join('')

      print "$"
      revenue_spaces = 14 - revenue_split.length
      revenue_spaces.times { |o| revenue_split << " " }
      print revenue_split.join('')

      puts
    end

    puts "*************************************************************"
    print "Totals:             "

    total_orders_spaces = 11 -total_orders.length
    total_customers_spaces = 15 -total_customers.length
    total_revenue_spaces = 14 - total_revenue.length

    total_orders_spaces.times { |o| total_orders << " "}
    print total_orders.join('')

    total_customers_spaces.times { |o| total_customers << " "}
    print total_customers.join('')
    print "$"
    total_revenue_spaces.times { |o| total_revenue << " "}
    print total_revenue.join('')
  end
end
