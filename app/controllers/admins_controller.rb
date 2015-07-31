class AdminsController < ApplicationController

    # before_filter :authenticate_admin
    before_filter :validate_admin_by_current_user
    before_action :set_admin, only: [:show, :edit, :update, :destroy]

    # GET /admins
    # GET /admins.json
    def index
        @admins = Admin.all
        respond_to do |format|
            format.html
        end
    end

    # GET /admins/1
    # GET /admins/1.json
    def show
        @carriers = Carrier.all
        @shipments = Shipment.all
        respond_to do |format|
            format.html
            format.js
        end
    end

    # GET /admins/new
    def new
        @admin = Admin.new
        respond_to do |format|
            format.html
        end
    end

    # GET /admins/1/edit
    def edit
    end

    # POST /admins
    # POST /admins.json
    def create
        @admin = Admin.new(admin_params)

        respond_to do |format|
            if @admin.save
                format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
                format.json { render :show, status: :created, location: @admin }
            else
                format.html { render :new }
                format.json { render json: @admin.errors, status: :unprocessable_entity }
            end
        end
    end
    # PATCH/PUT /admins/1
    # PATCH/PUT /admins/1.json
    def update
        respond_to do |format|
            if @admin.update(admin_params)
                format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
                format.json { render :show, status: :ok, location: @admin }
            else
                format.html { render :edit }
                format.json { render json: @admin.errors, status: :unprocessable_entity }
            end
        end
        end

    # DELETE /admins/1
    # DELETE /admins/1.json
    def destroy
        @admin.destroy
        respond_to do |format|
            format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    def profile
        @admin = Admin.find(params[:admin_id]) if @admin.nil?
        respond_to do |format|
            format.html
        end
    end

    def update_with_password
        respond_to do |format|
            if @admin.update_with_password(params[:admin])
                sign_in @admin, :bypass => true
                format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
            else
                format.html { render action: "edit" }
            end
        end
    end

    private

    def validate_admin_by_current_user
        @admin = current_user
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
        @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
        params.require(:admin).permit(:first_name, :last_name, :username, :email, :password, :role)
    end
end
