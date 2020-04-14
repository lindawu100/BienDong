class Cart

  def initialize(items = [])
    @items = items
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

  def total
    # tmp = 0
    # @items.each do |item|
    #     tmp += item.total
    # end
    #     if Time.now.month == 4 && Time.now.day == 1
    #         return tmp * 0.1
    #     else
    #         return tmp
    #     end
    # end

    # result = @items.reduce(0) { |sum, item| sum + item.total }
    result = @items.sum { |item| item.total }

    if Time.now.month == 4 and Time.now.day == 1
      result = result * 0.1
    end

    return result
  end

  def self.from_hash(hash = nil)
    if hash && hash["items"]
    #   items = []
    #   hash["items"].each do |item|
    #     # { "item_id" => 1, "quantity" => 3 },
    #     # { "item_id" => 2, "quantity" => 2 }
    #     items << CartItem.new(item["item_id"], item["quantity"])
    #   end
      items = hash["items"].map { |item|
        CartItem.new(item["item_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  def to_hash
    #   items = [
    #     { "item_id" => 1, "quantity" => 3 },
    #     { "item_id" => 2, "quantity" => 2 }
    #   ]
    
    #   items = []
    #   @items.each do |item|
    #     items << { "item_id" => item.item_id, "quantity" => item.quantity }
    #   end

    items = @items.map { |item|
      { "item_id" => item.item_id, "quantity" => item.quantity }
    }
    
    return { "items" => items }
  end   
end