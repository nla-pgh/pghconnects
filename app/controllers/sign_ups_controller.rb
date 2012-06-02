class SignUpsController < ApplicationController
  before_filter :signed_in_user

  def create
      @sign_up = SignUp.new
      @user = current_user 
      @event = Event.find(params[:event_id])
      @sign_up.user = @user
      @sign_up.event = @event

      if @sign_up.save!
          redirect_to user_events_path(@user)
          # TODO Do something
      end
  end
end
