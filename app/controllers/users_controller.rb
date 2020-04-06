class UsersController < ApplicationController
    skip_before_action :check_login
    def login
        @user = User.new
    end

    def sign_up
        @user = User.new
    end

    def sign_in
        # 查資料庫
        # select * from users
        # where email = ? amd password = ?
        user = User.find_by(email: user_params[:email], password: user_params[:password])

        if user
            session[:ccc] = user.email
            redirect_to root_path
        else
            redirect_to login_path
        end

    end

    def registration
        # user = params[:user]
        @user = User.new(user_params)

        if @user.save
            session[:ccc] = @user.email
            # success
            # TODO: 密碼加密
            # TODO: 幫登入
            redirect_to root_path
        else
            # fail
            render :sign_up
        end     
    end

    def logout
        session[:ccc] = nil
        redirect_to root_path
    end  

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
