class Api::V1::ItemsController < ApplicationController
# 做給外部的人看的時候篩掉這些，不然外部無法讀取檔案，但不驗證不保險，改用其他方法
# skip_before_action :verify_authenticity_token
# skip_before_action :check_login
    def favorite
        render json: {name: 'aaa', age: 18}
    end
end