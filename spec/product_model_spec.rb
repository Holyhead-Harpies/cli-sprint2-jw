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
    @product_model = Product.new('./db/test.sqlite')
  end
  it 'should raise an error without arguments' do
    expect{@product_model.create_new_product}.to raise_error(ArgumentError)
  end

  it 'should contain the method show_all_products' do
    expect(@product_model).to respond_to(:show_all_products)
  end
end