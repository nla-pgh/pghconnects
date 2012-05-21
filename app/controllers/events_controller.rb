class EventsController < ApplicationController
	def index
	end

	def update
	end

	def new
        @event = Event.new
	end

	def show
	end

	def destroy
	end

	def create
        site_ids = params[:event].delete(:site_ids)

        @event = Event.new(params[:event])
        @event.site_ids = site_ids

        if @event.save
            redirect_to event_path(@event)
        else
            render :new
        end
	end

	def edit
	end
end
