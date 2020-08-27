class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:email],
            params[:password]
        )

        if @user 
            login!(@user)
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = ["Invalid Credentials"]
            render :new, status: 422
        end

    end

    def destroy
            current_user.reset_session_token!
            @current_user = nil 
            session[:session_token] = nil
            redirect_to new_session_url
    end

end
