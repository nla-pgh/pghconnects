class AddressesController < ApplicationController
    def index
    end

    def new
        form_requirement_notice
        @user = User.find(params[:user_id])
        @addr = Address.new
    end

    def show
    end

    def create
        @user = User.find(params[:user_id])
        @addr = @user.addresses.new(params[:address])

        if not @addr.save
            render :new
        end
    end

    def destroy
    end
end
