class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# include Pundit
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception

		#--------Validate user as Admin-----------------------#
	def validate_admin
		@admin = current_user				if current_user.is_a? Admin
	end

	#--------Validate user as Customer---------------------#
	def validate_customer
		@customer = current_user			if current_user.is_a? Customer
	end

	#--------Validate user as Carrier---------------------#
	def validate_carrier
		@carrier = current_user				if current_user.is_a? Carrier
	end

	#--------Authenticate User as either Admin or Teacher else redirect---------------------#
	# def authenticate_admin_or_teacher
	#     redirect_to root_path, notice: "You aren't authorized to this action" unless current_user.is_a? Admin or current_user.is_a? Teacher
	# end

	#--------Authenticate User as Admin else redirect---------------------#
	def authenticate_admin
		redirect_to root_path, notice: "You aren't authorized to this action" unless current_user.is_a? Admin
	end

	#--------Authenticate Admin Role -> Academic else redirect---------------------#
	# def authenticate_academic_admin
	#     redirect_to root_path, notice: "You aren't authorized to this action" if current_user.is_a? Admin and !(current_user.admin_role == 1 or current_user.admin_role == 2) 
	# end

	#--------Authenticate Admin Role -> Finance else redirect---------------------#

	def authenticate_admin_user!
		redirect_to new_user_session_path unless current_user.try(:is_admin?)
	end

	def can_administer?
		current_user.is_a? Admin
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :type) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
	end
end
