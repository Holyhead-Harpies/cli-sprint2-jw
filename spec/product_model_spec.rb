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
  context 'Creating a new product...' do

    it 'should raise an error without arguments' do
      @product_model.create_new_product(@product_hash)
      expect{@product_model.create_new_product}.to raise_error(ArgumentError)
    end

  end

  context 'Showing all the products...' do
    it 'should contain the method show_all_products' do
      expect(@product_model).to respond_to(:show_all_products)
    end

    it 'should return an array' do
      expect(@product_model.show_all_products).to be_a(Array)
    end
  end

  context 'Returning one product' do

    it 'should contain a method to show one product' do
      expect(@product_model).to respond_to(:show_one_product)
    end

    it 'should raise an argument error if it does not have an argument' do
      expect{@product_model.show_one_product}.to raise_error(ArgumentError)
    end

    it 'should return an array with one item' do
      expect(@product_model.show_one_product(1)).to be_a(Array)
    end

    it 'should return the data that was requested' do
      expect(@product_model.show_one_product(1)[0][0]).to eq(1)
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
