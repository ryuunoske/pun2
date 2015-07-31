class CustomersController < ApplicationController

	before_action :authenticate_admin,                      only:   [:new, :create, :edit, :update, :destroy]
    before_action :validate_admin,                          only:   [:new, :create, :edit, :update, :destroy]
    before_action :set_customer,							only: 	[:show, :edit, :update, :destroy]
	def index
		@customers = Customer.all
		respond_to do |format|
			format.html
		end
	end

	def show
		@shipments = @customer.shipments
	end

	def new
		
	end

	def dashboard
	end

	private

	def set_customer
        @customer = Customer.find(params[:id])
    end
end
