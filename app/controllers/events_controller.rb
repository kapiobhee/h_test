class EventsController < ApplicationController
	before_action :set_event, :only => [:show,:edit,:update,:destroy]
	def index
		@events = Event.page(params[:page]).per(5)

		respond_to do |format|
		  format.html # index.html.erb
		  format.xml {render :xml => @events.to_xml }
		  format.json { render :json => @events.to_json }
		  format.atom { @feed_title = "My event list" } #index.atom.bulider
		end
	end
	def new
		@event = Event.new
	end
	def create
		flash[:notice] = "event was successfully created"
		@event = Event.new(event_params)
		if @event.save
		  redirect_to :action => :index
		else
		  render :action => :new
		end
	end
	def show
		@page_title = @event.name
	end
	def edit
	end
	def update
		flash[:notice] = "event was successfully created"
		if @event.update(event_params)
		  redirect_to :action => :show, :id => @event
		else
		  render :action => :edit
		end
	end
	def destroy
		flash[:alert] = "event was successfully deleted"
		@event.destroy

		redirect_to :action => :index
	end

	private

	def event_params
		params.require(:event).permit(:name, :description)
	end
	def set_event
		@event = Event.find(params[:id])
	end
end