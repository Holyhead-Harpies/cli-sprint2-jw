require_relative '../models/product_model'

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

  ## @brief      Gets produts from model and prints to the console
  ##
  ## @param      customerId
  ##
  ## @return    Returns a list of products
  ##

  def show_products(customerId)
    products = Product.new.get_products(customerId)
    products.each_with_index  do |p, i|
      puts "#{p['ProductId']}. #{p[0]}"
    end
  end

  ## @brief      Remove products from model and prints to the console
  ##
  ## @param      customerId
  ##
  ## @return    nothing
  ##

  def remove_product(customerId)
    puts 'Select a product: '
    show_products(customerId)
    product_id = STDIN.gets.chomp
    Product.new.remove_product(product_id.to_i)
    return true
  end
end


  def show_product(customerId,productId)
    product = Product.new.get_product(customerId,productId)
    puts "1. Change Title '#{product[0][0]}'"
    puts "2. Change Description '#{product[0][1]}'"
    puts "3. Change Price '#{product[0][2]}'"
    puts "4. Change Quantity '#{product[0][3]}'"
    return product
  end


  def update_product(customerId)
    puts 'Select a product: '
    show_products(customerId)
    product_id = STDIN.gets.chomp
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

    Product.new.update_product(customerId,product_id,field_change,value_change)
  end
end
