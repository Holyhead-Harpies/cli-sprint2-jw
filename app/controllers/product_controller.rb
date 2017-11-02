require_relative '../models/product_model'

class ProductController
  attr_accessor :title, :description, :price, :quantity, :product_hash, :product_model

  def initialize(title, description, price, quantity)
    @title = title
    @description = description
    @price = price
    @quantity = quantity
    @product_hash = Hash.new
    @product_model = Product.new
  end


  def add_customer_id(customerId)
    @product_hash[:customer_id] = customerId
  end

  def get_title(title)
    @title = title.to_s
    @product_hash[:title] = @title
  end

  def get_description(description)
    @description = description.to_s
    @product_hash[:description] = @description
  end

  def get_price(price)
    @price = price.to_s
    @product_hash[:price] = @price
  end

  def get_quantity(quantity)
    @quantity = quantity.to_s
    @product_hash[:quantity] = @quantity
  end

  def create_product(customerId)
    add_customer_id(customerId)
    puts "Enter Product TITLE: "
    title = STDIN.gets.chomp
    get_title(title)
    puts "Enter Product DESCRIPTION: "
    description = STDIN.gets.chomp
    get_description(description)
    puts "Enter Product PRICE: "
    price = STDIN.gets.chomp
    get_price(price)
    puts "Enter Product QUANTITY: "
    quantity = STDIN.gets.chomp
    get_quantity(quantity)
    Product.new.create_new_product(@product_hash)
  end
end


