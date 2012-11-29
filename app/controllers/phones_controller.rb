class PhonesController < ApplicationController
    def index
    end

    def new
        form_requirement_notice
        @user = User.find(params[:user_id])
        @phone = Phone.new
    end

    def show
    end

    def create
        @user = User.find(params[:user_id])
        @phone = @user.phones.new(params[:phone])

        if @phone.save
            @phone.user = @user
            flash[:success] = " Phone information saved!
                                    Thank you, <strong>#{@user.first}</strong>!
                                    To receive your login information, please fill in the remaining forms."
            redirect_to new_user_email_path(@user)
        else
            person_error @user
            render :new
        end
    end

    def destroy
    end
end
