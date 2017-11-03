require_relative '../../app/controllers/product_controller'
require 'date'

class Product

  def initialize
    @db = SQLite3::Database.new('../db/sprint2.sqlite')
    @db.results_as_hash = true
  end

  def create_new_product(hash_from_controller)
    d = Datetime.now
    date = "#{d.month}/#{d.day}/#{d.year}"
    hash_from_controller[:created_at] = date
    hash_from_controller[:updated_at] = date
    begin
      statement = "INSERT INTO Products(Title, Description, Price, Quantity, created_at, updated_at) VALUES(
                  '#{hash_from_controller[:title]}', '#{hash_from_controller[:description]}',
                  '#{hash_from_controller[:price]}', '#{hash_from_controller[:quantity]}',
                  '#{hash_from_controller[:created_at]}', '#{hash_from_controller[:updated_at]}'"
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
end
