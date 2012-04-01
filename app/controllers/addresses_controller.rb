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

        if @addr.save
            @addr.user = @user

            flash.now[:success] = "Address information saved! Thank you, <strong>#{@user.first}</strong>! To receive your login information, please fill in the remaining forms."

            redirect_to new_user_phone
        else
            person_error @user
            render :new
        end
    end

    def destroy
    end
end
