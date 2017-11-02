require_relative '../../app/controllers/product_controller'

class Product
  def create_new_product(hash_from_controller)
    d = Date.now
    date = "#{d.month}/#{d.day}/#{d.year}"
    hash_from_controller[:created_at] = date
    # hash_from_controller[:updated_at] = date
    db = SQlite3::Database.open('../db/sprint2.sqlite')
    db.execute(hash_from_controller)
    db.close
  end
end
