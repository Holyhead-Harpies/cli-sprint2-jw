require_relative '../app/models/product_model'
require 'date'


describe Product do
  before(:each) do
    d = DateTime.now
    date = "#{d.month}/#{d.day}/#{d.year}"
    @product_hash = {
      title: 'Widget',
      description: 'This is our first widget',
      price: 55.32,
      quantity: 5,
      created_at: date,
      updated_at: date
    }
    @product_model = Product.new
  end
  context '.create_new_product'do
    it 'should raise an error without arguments' do
      expect{@product_model.create_new_product}.to raise_error(ArgumentError)
    end
  end
  context '.get_products with no args 'do
    it 'should raise an error without arguments' do
      expect{@product_model.get_products}.to raise_error(ArgumentError)
    end
  end
  context '.remove_products with no args 'do
    it 'should raise an error without arguments' do
      expect{@product_model.remove_product}.to raise_error(ArgumentError)
    end
  end
end
