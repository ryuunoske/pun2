class CarriersController < ApplicationController

	before_action :set_carrier, only: [:show, :edit, :update, :destroy]

	def index
		@carriers = Carrier.all
		respond_to do |format|
			format.html
		end
	end

	def show
		respond_to do |format|
			format.html
		end
	end

	private

	def set_carrier
        @carrier = Carrier.find(params[:id])
    end
end
