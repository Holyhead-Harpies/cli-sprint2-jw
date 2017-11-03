require 'date'
require 'sqlite3'

##
## @brief      Class for Product model.
##
class Product

  def initialize(database = './db/sprint2.sqlite')
    @db = SQLite3::Database.open(database)
    @db.results_as_hash = true
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
      p @db
      p hash_from_controller
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

  def show_all_products
    
  end
end
