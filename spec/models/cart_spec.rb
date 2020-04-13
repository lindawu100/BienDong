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
  end
  describe "進階功能" do
  end
end