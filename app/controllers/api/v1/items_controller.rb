class Api::V1::ItemsController < ApplicationController
# 做給外部的人看的時候篩掉這些，不然外部無法讀取檔案，但不驗證不保險，改用其他方法
# skip_before_action :verify_authenticity_token
# skip_before_action :check_login
    def favorite
        item = Item.find(params[:id])

        if item.favorited_by(current_user)
            # 移除最愛
            # FavoriteItem.find_by(item: item, user: current_user).destroy
            current_user.items.delete(item)
            render json: {status: '-'}
        else
            # 加
            current_user.items << item
            render json: {status: 'favorited'}
        end
    end
end