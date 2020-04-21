class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, 
                with: :record_not_found

    before_action :check_login

    # 在此只有controller可以取用方法，這句讓view可以用這個方法
    helper_method :current_user, :current_cart

    private
    def check_login
        redirect_to login_path unless :current_user
    end
    def current_user
        # User.find(session[:ccc]) 在登出後，session會被清除，在每個頁面共用的header有呼叫current_user方法，會噴出錯誤，改用find_by，在找不到時會回傳nil
        User.find_by(id: session[:ccc])
    end
    def current_cart
        @_ca123 ||= Cart.from_hash(session[:carty])
    end
    def record_not_found
        render file: 'public/404.html',
             status: 404,
             layout: false
    end
end
