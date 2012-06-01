class SignUpsController < ApplicationController
    def create
        @sign_up = SignUp.new
        @user = User.find(params[:user_id])
        @event = Event.find(params[:event_id])
        @sign_up.user = @user
        @sign_up.event = @event

        if @sign_up.save!
            redirect_to user_events_path(@user)
            # TODO Do something
        end
    end
end
