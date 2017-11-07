require 'date'
require 'sqlite3'

##
## @brief      Class for Product model.
##
class Product

  def initialize
    @db = SQLite3::Database.open('./db/sprint2.sqlite')
    @db.results_as_hash = true
  end


  ## @brief      creates a new product from the controller hash and passes it to the database
  ##
  ## @param      hash_from_controller
  ##
  ## @return     returns nothing
  ##

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

  ## @brief      gets products based on customerId
  ##
  ## @param      customerId
  ##
  ## @return     returns customers products
  ##

  def get_products(customerId)
    begin
      products = "SELECT Products.title, Products.ProductId from Products where Products.OwnerId == #{customerId.to_i}"
      @db.execute products
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.show_products'
      puts e
      @db.rollback
    ensure
      @db.close
    end
  end

  ## @brief      removes product based on item not being in the cart/order
  ##
  ## @param      productId
  ##
  ## @return     message of error or confirmation
  ##

  def remove_product(productId)
    begin
      truth = @db.execute("SELECT * from OrdersProducts WHERE #{productId} == OrdersProducts.ProductId")
      if truth == []
        statement = "DELETE FROM Products WHERE Products.ProductId == #{productId}"
        @db.execute statement
        puts 'Product removed successfully.'
      else
        puts "That product is in an active order"
      end
    rescue SQLite3::Exception => e
      puts 'Exception occurred from ProductModel.remove_product'
      puts e
    ensure
      @db.close
    end
  end

  def get_product_price_info(product_id)
    begin 
      return @db.execute("select p.ProductId, p.Title, p.Price from Products p where p.ProductId = #{product_id}")
    rescue SQLite3::Exception => e
      @db.rollback
    else
      
    ensure
      @db.close
      
    end
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
      statement = "UPDATE Products SET #{field_change} = '#{value_change}' WHERE productID = #{productId} and OwnerId = #{customerId};"
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

  def get_stale_products
    now = Date.today
    one_eighty_days_ago = (now - 180)
    ninety_days_ago = (now-90)
    begin
      stale_products =  "SELECT Products.ProductId as Product from Products join OrdersProducts where Products.ProductId != OrdersProducts.ProductId and
                            Products.created_at < #{one_eighty_days_ago}
                            UNION ALL
                            SELECT  OrdersProducts.ProductId from OrdersProducts where created_at < #{ninety_days_ago}
                            UNION ALL
                            SELECT  Products.ProductId from Products join Orders, OrdersProducts where Orders.completed == '1' and
                            OrdersProducts.ProductId != null and Products.quantity > 0 and Products.created_at < #{one_eighty_days_ago}"
      @db.transaction
      @db.execute stale_products
      stale_products

    end
    begin

    end
  end

end
