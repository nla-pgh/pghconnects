class EmailsController < ApplicationController
    def index
    end

    def new
        form_requirement_notice
        @user = User.find(params[:user_id])
        @email = Email.new
    end

    def show
    end

    def create
        @user = User.find(params[:user_id])
        @email = @user.emails.new(params[:email])

        if @email.save
            @email.user = @user
            flash[:success] = " Email information saved!
                                    Thank you, <strong>#{@user.first}</strong>!
                                    To receive your login information, please fill in the remaining forms."
            redirect_to new_user_work_history_path(@user)
        else
            person_error @user
            render :new
        end
    end

    def destroy
    end
end
