class EventsController < ApplicationController
	def index
        @events = Event.all
	end

	def update
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])

        site_ids = params[:event].delete(:site_ids)

        if @event.update_attributes(params[:event])
            @event.site_ids = site_ids
            redirect_to user_event_path(@user, @event)
        else
            render :edit
        end
	end

	def new
        @user = User.find(params[:user_id])
        @event = Event.new
	end

	def show
        @user = User.find(params[:user_id])
        @event = Event.find(params[:id])
        @sign_up = SignUp.new
	end

	def destroy
	end

	def create
        site_ids = params[:event].delete(:site_ids)

        # TODO Find a way to convert form's DateTime fields to be stored
        # correctly (EST to UTC)
        @event = Event.new(params[:event])
        @event.site_ids = site_ids

        if @event.save
            redirect_to event_path(@event)
        else
            render :new
        end
	end

	def edit
        @event = Event.find(params[:id])
	end
end
