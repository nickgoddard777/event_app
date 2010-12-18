class EventsController < ApplicationController
	
	def index
		@title = "All Events"
		@events = Event.paginate(:page => params[:page])
	end
	
	def show
		@event = Event.find(params[:id])
		@title = @event.title
	end
	
	def new
		@event = Event.new
		@title = "New Event"
	end
	
	def create
		@event = Event.new(params[:event])
		if @event.save
			flash[:success] = "Event was successfully created."
			redirect_to @event
		else
			@title = "New Event"
			render 'new'
		end
	end
	
	def edit
		@event = Event.find(params[:id])
		@title = "Edit Event"
	end
	
	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(params[:event])
			flash[:success] = "Event updated."
			redirect_to @event
		else
			@title = "Edit Event"
			render 'edit'
		end
	end
end
