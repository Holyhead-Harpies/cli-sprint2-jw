require 'date'
require 'sqlite3'

##
## @brief      Class for Product model.
##
class ProductModel

  def initialize(database = './db/test.sqlite')
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

  ## @brief      queries database for all Products data in the Products table
  ## @param      none
  ## @return     returns all values for Products

  def show_all_products
    @db = open_db_connection
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
    @db.results_as_hash
    statement = "SELECT ProductId, OwnerId, Title, Description, Price, Quantity FROM Products WHERE ProductID = #{product_id}"
    @db.transaction
    product = @db.execute statement
    @db.close
    product
  end

end