class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy, :add_to_cart] 
  
    def index
      # @items = Item.where(delete_at: nil)
      # @items = Item.available
      @items = Item.all
    end
  
    def show
      @comment = Comment.new
      # 抓comment資料並反向排序
      # @comment = @item.comments.order(id: :desc)
      
      # 不要在controller排序的話，可以去model排
      @comments = @item.comments.includes(:user) #eager loading
    end
  
    def new
      @item = Item.new
    end
  
    def create
      @item = Item.new(item_params)
  
      if @item.save
        redirect_to items_path, notice: '成功新增餐點!'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @item.update(item_params)
        redirect_to items_path, notice: '成功更新餐點!'
      else
        render :edit
      end
    end
  
    def destroy
      @item.destroy
      # @item.update(delete_at: Time.now)
      redirect_to items_path, notice: '成功刪除餐點'
    end

    def add_to_cart
      # cart = Cart.from_hash(session[:carty])
      current_cart.add_item(@item.id)
      session[:carty] = current_cart.to_hash
      
      redirect_to root_path, notice: '已加到購物車'
    end
  
    private
    def find_item
      @item = Item.find(params[:id])
      # @item = Item.find_by!(params[:id], delete_at: nil)

    end
  
    def item_params
      params.require(:item).permit(:name, 
                                   :description, 
                                   :price, 
                                   :category_id, 
                                   :cover, 
                                   :spec)
    end
  end