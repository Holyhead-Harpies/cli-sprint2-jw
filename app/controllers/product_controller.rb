require_relative '../models/product_model'

##
## @brief      Class for Prodcut Controller. Initalized with a
#               customer_id, title, description, price, quantity
##
class ProductController
  attr_accessor :title, :description, :price, :quantity, :product_hash, :product_model

  def initialize(customer_id, title, description, price, quantity)
    @customer_id = customer_id
    @title = title
    @description = description
    @price = price
    @quantity = quantity
    @product_hash = Hash.new

  end

  ## @brief      Adds customer_id to product_hash
  ##
  ## @param      customer_id
  ##
  ## @return
  ##

  def add_customer_id(customerId)
    @customer_id = customerId
    @product_hash[:customer_id] = @customer_id
  end

  ## @brief      Adds title to product_hash
  ##
  ## @param      title
  ##
  ## @return
  ##

  def get_title(title)
    @title = title.to_s
    @product_hash[:title] = @title
  end

  ## @brief      Adds description to product_hash
  ##
  ## @param      description
  ##
  ## @return
  ##

  def get_description(description)
    @description = description.to_s
    @product_hash[:description] = @description
  end

  ## @brief      Adds price to product_hash
  ##
  ## @param      price
  ##
  ## @return
  ##

  def get_price(price)
    @price = price.to_s
    @product_hash[:price] = @price
  end

  ## @brief      Adds quantity to product_hash
  ##
  ## @param      quantity
  ##
  ## @return
  ##

  def get_quantity(quantity)
    @quantity = quantity.to_s
    @product_hash[:quantity] = @quantity
  end

  ## @brief      Captures users input and calls other Procuct Controller method
  ##
  ## @param      customerId
  ##
  ## @return    New Product model passing it the recently updated product_hash
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
    Product.new.create_new_product(@product_hash)
  end
end


