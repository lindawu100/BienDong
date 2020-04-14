class Cart

  def initialize
    @items = []
  end

  def add_item(item_id)
    # 檢查是否存在傳入的商品id
    found_item = @items.find { |item| item.item_id == item_id }
    
    if found_item
        # 增加數量
        found_item.increment!
    else
        @items << CartItem.new(item_id)
    end
  end

  def empty?
    @items.empty?
  end

  def items
    @items
  end

end