class OrdersController < ApplicationController
    def create
        # @order = Order.new(order_params)
        # @order.user = current_user

        # 從user角度建立訂單，這行可以取代上面兩行
        @order = current_user.orders.build(order_params)

        # 抓購物車內容給訂單
        current_cart.items.each do |cart_item|
            item = OrderItem.new(item: cart_item.item,
                                 price: cart_item.item.price,
                                 quantity: cart_item.quantity)
            @order.order_items << item
        end

        if @order.save
            # 刷卡(串第三方金融)
            # 清空供物車
            redirect_to root_path, notice: 'ok'
        else
            redirect_to root_path, notice: 'not ok'
        end
    end

    private
    def order_params
        params.require(:order).permit(:receiver, :phone, :addres)
    end
end
