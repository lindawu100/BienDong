require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      # Arrange
      cart = Cart.new
      # Act
      cart.add_item(1)
      # Assert
      expect(cart.empty?).to be false
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變" do
      cart = Cart.new

      cart.add_item(1)
      cart.add_item(1)
      cart.add_item(2)
      cart.add_item(2)
      cart.add_item(1)
      2.times { cart.add_item(1) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
      expect(cart.items.second.quantity).to be 2
    end

    it "商品可以放到購物車裡，也可以再拿出來" do
      # Arrange
      cart = Cart.new

      # cat1 = Category.create(name: 'Cat1')
      # cat1 = FactoryBot.create(:category)
      # i1 = cat1.items.create(name: 'item1', price: 100)
      # i2 = cat1.items.create(name: 'item2', price: 80)
      i1 = FactoryBot.create(:item)
      i2 = FactoryBot.create(:item)
      # Act
      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }
      # Assert
      expect(cart.items.first.item).to be_an Item
      # expect(cart.items.first.item.price).to be 100
      expect(cart.items.first.item.price).to be i1.price
      # expect(cart.items.first.item.id).to be 1
      expect(cart.items.first.item.id).to be i1.id
      expect(cart.items.first.item.name).to eql i1.name
      expect(cart.items.first.item.name).not_to eql 'item1'
    end
  end
  describe "進階功能" do
  end
end