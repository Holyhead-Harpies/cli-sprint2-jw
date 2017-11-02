require_relative './../app/controllers/product_controller'


describe 'ProductController' do
  before(:each) do
    @product = ProductController.new(title: 'Test')
  end
  context 'initialize is run' do
    it 'has four arguments' do
      expect(@product).to respond_to(:initialize).with(4).arguments
    end
    it 'has less than four arguments' do
      expect{@paymnet.intialize}.to raise_error(ArgumentError)
    end
  end
end