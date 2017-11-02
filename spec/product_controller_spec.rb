require_relative '../app/controllers/product_controller'

describe 'ProductController' do
  before(:each) do
    @product = ProductController.new('Yo', 'This is great', '25.99','5')
  end
  context 'is initialized,' do
    it 'has the same title as what was passed' do
      expect(@product.get_title('Yo')).to eq('Yo')
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
end

