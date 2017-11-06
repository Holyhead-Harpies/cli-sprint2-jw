require_relative '../app/controllers/product_controller'

describe ProductController do
  before(:each) do
    @product = ProductController.new
  end
  context 'is initialized,' do
    it 'has the same title as what was passed' do
      expect(@product.add_customer_id(54)).to eq(54)
    end
    it 'has the same description as what was passed' do
      expect(@product.get_description('This is great')).to eq('This is great')
    end
    it 'has the same price as what was passed' do
      expect(@product.get_price('25.99')).to eq('25.99')
    end
    it 'has the same quantity as what was passed' do
      expect(@product.get_quantity('5')).to eq('5')
    end
    it 'has the correct customerid' do
      @product.add_customer_id(1)
      expect(@product.product_hash[:customer_id]).to eq(1)
    end
  end
  context 'is passed integer' do
    it '.get_title should return a string' do
      expect(@product.get_title(5)).to eq('5')
    end
    it '.get_description should return a string' do
      expect(@product.get_description(72348234)).to eq('72348234')
    end
    it '.get_price should return a string' do
      expect(@product.get_price(83434.9349)).to eq('83434.9349')
    end
    it '.get_quantity should return a string' do
      expect(@product.get_quantity(7676)).to eq('7676')
    end
    context '.remove_product is passed no arg' do
      it 'should raise an error without arguments' do
        expect{@product.remove_product}.to raise_error(ArgumentError)
      end
    end
    context '.show_products' do
      it 'can show a list of products' do
        expect(@product).to respond_to(:show_products)
      end
    end
  end
end

