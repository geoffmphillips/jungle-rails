require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be valid when all fields included' do
      @category = Category.new ({ name: "category" })
      @product = Product.new({ category: @category, name: "name", price: 2.99, quantity: 10 })
      expect(@product).to be_valid
    end

    it 'should be invalid if no product name' do
      @category = Category.new ({ name: "category" })
      @product = Product.new({ category: @category, name: nil, price: 2.99, quantity: 10 })
      expect(@product).to_not be_valid
    end

    it 'should be invalid if no price' do
      @category = Category.new ({ name: "category" })
      @product = Product.new({ category: @category, name: "name", price: nil, quantity: 10 })
      expect(@product).to_not be_valid
    end

    it 'should be invalid if no quantity' do
      @category = Category.new ({ name: "category" })
      @product = Product.new({ category: @category, name: "name", price: 2.99, quantity: nil })
      expect(@product).to_not be_valid
    end

    it 'should be invalid if no category' do
      @product = Product.new({ category: nil, name: "name", price: 2.99, quantity: 10 })
      expect(@product).to_not be_valid
    end
  end
end
