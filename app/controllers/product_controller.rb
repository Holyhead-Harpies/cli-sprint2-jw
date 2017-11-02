require_relative '../models/product_model'

class ProductController
  attr_accessor :title, :description, :price, :quantity

  def initialize(title, description, price, quantity)
    @title = title
    @description = description
    @price = price
    @quantity = quantity
  end

  @product_model = Product.new

  def create_new_product
    @product_hash = Hash.new
  end

  def get_title(title)
    @title = title
    @product_hash[:title] = @title
  end

  def get_description(description)
    @description = description
    @product_hash[:description] = @description
  end

  def get_price(price)
    @price = price
    @product_hash[:price] = @price
  end

  def get_quantity(quantity)
    @quantity = quantity
    @product_hash[:quantity] = @quantity
  end
end


