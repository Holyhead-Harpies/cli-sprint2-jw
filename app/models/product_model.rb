require 'date'
require 'sqlite3'

##
## @brief      Class for Product model.
##
class ProductModel

  def initialize(database = './db/sprint2.sqlite')
    @db = SQLite3::Database.open(database)
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
    products = @db.execute "SELECT * FROM Products"
    @db.close
    products
  end

  def show_one_product(product_id)
    statement = "SELECT * FROM Products WHERE ProductID = #{product_id}"
    product = @db.execute statement
    @db.close
    product
  end

end


# db.execute "SELECT * FROM artist WHERE name = :artist_named_jisie AND artistId = :an_id", artist_named_jisie, an_id


