class UsersController < ApplicationController
    before_filter :authenticate_user_role_and_redirect, except: [:edit, :update]

    def index
        @users = User.all
        respond_to do |format|
            format.html
        end
    end

    def edit
        @user  = User.find_by_id(params[:id])
    end

    private

    def secure_params
        params.require(:user).permit(:type => [])
    end


	def authenticate_user_role_and_redirect
        case current_user.type
            when "Admin"
                redirect_to admin_path(current_user) and return
            when "Carrier"
                redirect_to carrier_path(current_user) and return
            when "Customer"
                redirect_to customer_path(current_user) and return
        end
    end
end
