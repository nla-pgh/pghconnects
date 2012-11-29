class WorkHistoriesController < ApplicationController
    def index
    end

    def new
        form_requirement_notice
        @user = User.find(params[:user_id])
        @work_history = WorkHistory.new
    end

    def show
    end

    def create
        @user = User.find(params[:user_id])
        @work_history = @user.work_histories.new(params[:work_history])

        if @work_history.save
            @work_history.user = @user
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
