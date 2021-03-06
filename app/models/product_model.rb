require 'date'
require 'sqlite3'

##
## @brief      Class for Product model.
##
class ProductModel

  def initialize(database = './db/sprint2.sqlite')
    @database = database
  end

  ## @brief      opens a connection to the database specified when class is initialized
  ## @param      none
  ## @return     returns connection to database

  def open_db_connection
    SQLite3::Database.open(@database)
  end

  ## @brief      creates a new product from the controller hash and passes it to the database
  ## @param      hash_from_controller
  ## @return     returns nothing

  def create_new_product(hash_from_controller)
    d = DateTime.now
    date = "#{d.month}/#{d.day}/#{d.year}"
    hash_from_controller[:created_at] = date
    hash_from_controller[:updated_at] = date
    begin
      statement = "INSERT INTO Products(OwnerId, Title, Description, Price, Quantity, created_at, updated_at) VALUES( '#{hash_from_controller[:customer_id]}',
                  '#{hash_from_controller[:title]}', '#{hash_from_controller[:description]}',
                  '#{hash_from_controller[:price]}', '#{hash_from_controller[:quantity]}',
                  '#{hash_from_controller[:created_at]}', '#{hash_from_controller[:updated_at]}')"
      @db = open_db_connection
      @db.results_as_hash = true
      @db.transaction
      @db.execute statement
      @db.commit
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.create_new_product'
      puts e
      @db.rollback
    ensure
      @db.close
      end
  end

  ## @brief      gets products based on customerId
  ##
  ## @param      customerId
  ##
  ## @return     returns customers products
  ##

  def get_products(customerId)
    begin
      products = "SELECT Products.title, Products.ProductId from Products where Products.OwnerId == #{customerId.to_i}"
      @db = open_db_connection
      @db.results_as_hash = true
      @db.execute products
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.show_products'
      puts e
      @db.rollback
    ensure
      @db.close
    end
  end

  ## @brief      finds all orders from the OrdersProducts table by productID
  ##
  ## @param      productId as an integer
  ##
  ## @return     orderIds for all orders the product is on or calls a method to remove the product from the Products table if it has never been ordered.
  ##

  def find_orders_with_product(productId)
    begin
      @db = open_db_connection
      @db.results_as_hash = true
      truth = @db.execute("SELECT op.OrderId from OrdersProducts op WHERE #{productId} == op.ProductId group by op.OrderId")
      if truth == []
        remove_product(productId)
      else
        return truth
      end
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.find_orders_with_product'
      puts e
    ensure
      @db.close
    end
  end


  ## @brief removes a product from the products table
  ## @params takes productId as an integer
  ## @returns text output denoting the product was successfully removed
  def remove_product(productId)
    @db = open_db_connection
    @db.results_as_hash = true
    statement = "DELETE FROM Products WHERE Products.ProductId == #{productId}"
    @db.execute statement
    puts 'Product removed successfully.'
  end

  ## @brief gets product information based on product id
  ## @params product_id as an integer
  ## @returns product information for the desired product
  def get_product_price_info(product_id)
    begin 
      @db = open_db_connection
      @db.results_as_hash = true
      return @db.execute("select p.ProductId, p.Title, p.Price from Products p where p.ProductId = #{product_id}")
    rescue SQLite3::Exception => e
      @db.rollback
    else
      
    ensure
      @db.close
      
    end
  end

  ## @brief gets the current available quantity for the product desired. Called in the reduce_quantity method
  ## @params hash of product information
  ## @returns quantity as an integer
  def get_quantity(product)
    @db = open_db_connection
    @db.results_as_hash = true
    quantity = @db.execute("select p.Quantity from Products p where p.ProductId = #{product[0]}")
    return quantity
  end

  ## @brief updates the quantity available by reducing the quantity by the amount ordered on the order being closed
  ## @params takes a hash of product information
  ## @returns 
  def reduce_quantity(product)
    old_quantity = get_quantity(product)
    new_quantity = old_quantity[0][0] - product[:number_on_order]
    @db = open_db_connection  
    @db.results_as_hash = true  
    @db.execute("update Products set Quantity = #{new_quantity} where ProductId = #{product[0]}")
    @db.close
  end

  ##
  ## @brief      gets a single product for specific customer
  ##
  ## @param      customerId  The customer identifier
  ## @param      productId   The product identifier
  ##
  ## @return     The product
  ##
  def get_product(customerId,productId)
    begin
      products = "SELECT Products.title, Products.description, Products.price, Products.quantity from Products where Products.OwnerId = #{customerId} and Products.ProductId = #{productId}"
      @db = open_db_connection
      @db.results_as_hash = true
      @db.transaction
      @db.execute products
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.show_products'
      puts e
      @db.rollback
    ensure
      @db.close
    end
  end


  ##
  ## @brief      updates a single product
  ##
  ## @param      customerId    The customer identifier
  ## @param      productId     The product identifier
  ## @param      field_change  The field to change
  ## @param      value_change  The value to change
  ##
  ## @return
  ##
  def update_product(customerId,productId,field_change,value_change)
    begin
      @db = open_db_connection
      @db.results_as_hash = true
      statement = "UPDATE Products SET '#{field_change}' = '#{value_change}' WHERE productID = #{productId} and OwnerId = #{customerId};"
      @db.transaction
      @db.execute statement
      @db.commit
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.update_product'
      puts e
    ensure
      @db.close
    end
  end

  ## @brief      queries database for all Products data in the Products table
  ## @param      none
  ## @return     returns all values for Products

  def show_all_products
    @db = open_db_connection
    @db.results_as_hash = true
    @db.results_as_hash
    @db.transaction
    products = @db.execute "SELECT ProductId, OwnerId, Title, Description, Price, Quantity FROM Products"
    @db.commit
    @db.close
    products
  end

  ## @brief      queries database for one product
  ## @param      product id
  ## @return     returns specified row from Products

  def show_one_product(product_id)
    @db = open_db_connection
    @db.results_as_hash = true
    @db.results_as_hash
    statement = "SELECT ProductId, Title FROM Products WHERE ProductID = #{product_id}"
    @db.transaction
    product = @db.execute statement
    @db.close
    product
  end

end

