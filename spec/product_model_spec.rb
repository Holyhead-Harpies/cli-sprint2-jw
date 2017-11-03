require_relative '../app/models/product_model'
require 'date'

describe ProductModel do
  before(:each) do
    d = DateTime.now
    date = "#{d.month}/#{d.day}/#{d.year}"
    @product_hash = {
      OwnerId: 1,
      title: 'Thingie',
      description: 'This is the best thingie',
      price: 66.66,
      quantity: 15,
      created_at: date,
      updated_at: date
    }
    @product_model = ProductModel.new('./db/sprint2.sqlite')
  end
  it 'should raise an error without arguments' do
    @product_model.create_new_product(@product_hash)
    expect{@product_model.create_new_product}.to raise_error(ArgumentError)
  end

  it 'should contain the method show_all_products' do
    expect(@product_model).to respond_to(:show_all_products)
  end

  it 'should return a hash' do
    expect(@product_model.show_all_products).to be_a(Array)
  end
end