require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new } # 取代Cart.new
    # Ruby memorization，上面那行可做到類似這個方法的效果
    # def cart
    #   @cart ||= Cart.new
    # end
  describe "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      # Arrange
      # cart = Cart.new
      # Act
      cart.add_item(1)
      # Assert
      # xxx? = be_xxx
      # expect(cart.empty?).to be false
      expect(cart).not_to be_empty
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變" do
      # cart = Cart.new

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
      # cart = Cart.new

      # cat1 = Category.create(name: 'Cat1')
      # cat1 = FactoryBot.create(:category)
      # i1 = cat1.items.create(name: 'item1', price: 100)
      # i2 = cat1.items.create(name: 'item2', price: 80)
      i1 = create(:item)
      i2 = create(:item)

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

    it "可以計算整台購物車的總消費金額" do
      # cart = Cart.new
      i1 = create(:item, price: 50)
      i2 = create(:item, price: 100)

      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }

      expect(cart.total).to be 350
    end

    it "特別活動可能可搭配折扣(4/1打一折)" do
      # cart = Cart.new
      i1 = create(:item, price: 50)
      i2 = create(:item, price: 100)

      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }
      t = Time.local(2008, 4, 1, 10, 5, 0)
      Timecop.travel(t)

      expect(cart.total).to be 35.0
      expect(cart.total).to eq 35
    end
  end
  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash，存到 Session 裡" do
      # cart = Cart.new
      i1 = create(:item, price: 50)
      i2 = create(:item, price: 100)

      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }

      # result = {
      #   "items" => [
      #     { "item_id" => 1, "quantity" => 3 },
      #     { "item_id" => 2, "quantity" => 2 }
      #   ]
      # }
      expect(cart.to_hash).to eq cart_hash
    end

    it "Hash還原成購物車的內容" do
      # result = {
      #   "items" => [
      #     { "item_id" => 1, "quantity" => 3 },
      #     { "item_id" => 2, "quantity" => 2 }
      #   ]
      # }

      cart = Cart.from_hash(cart_hash)

      expect(cart.items.count).to be 2
    end
  end

  private
  def cart_hash # 將result包成方法
    {
      "items" => [
        { "item_id" => 1, "quantity" => 3 },
        { "item_id" => 2, "quantity" => 2 }
      ]
    }
  end
end