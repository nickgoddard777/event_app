require 'spec_helper'

describe EventsController do
	render_views
	
	describe "GET 'index'" do

		before(:each) do
			@event = Factory(:event)
			second = Factory(:event)
			third  = Factory(:event)
			@events = [@event, second, third]
			30.times do
				@events << Factory(:event)
			end
		end
		
		it "should be successful" do
			get :index
				response.should be_success
		end
		
		it "should have the right title" do
			get :index
			response.should have_selector("title", :content => "All Events")
		end
		
		it "should have an element for each event" do
			get :index
			@events[0..2].each do |event|
				response.should have_selector("li", :content => event.title)
			end
		end
		
		it "should paginate users" do
			get :index
			response.should have_selector("div.pagination")
			response.should have_selector("span.disabled", :content => "Previous")
			response.should have_selector("a",	:href => "/events?page=2",
												:content => "2")
			response.should have_selector("a",	:href => "/events?page=2",
                                           		:content => "Next")
        end
	end
	
	describe "GET 'new'" do
		
		it "should be successful" do
			get :new
			response.should be_success
		end
		
		it "should have the right title" do 
			get :new
			response.should have_selector("title", :content => "New Event")
		end
	end
	
	describe "POST 'create'" do
 
		describe "failure" do

			before(:each) do
				@attr = { :title => "", :description => "", :start_date => "",
					:end_date => "", :link_url => "" }
			end

			it "should not create an event" do
				lambda do
					post :create, :event => @attr
					end.should_not change(Event, :count)
			end

			it "should have the right title" do
				post :create, :event => @attr
				response.should have_selector("title", :content => "New Event")
			end

			it "should render the 'new' page" do
				post :create, :event => @attr
				response.should render_template('new')
			end
		end
    
		describe "success" do

			before(:each) do
				@attr = { :title => "New Event", :description => "This is a new event",
					:start_date => "01/01/2020", :end_date => "02/01/2020", 
					:link_url => "http://www.test.com" }
			end
			

			it "should create an event" do
				lambda do
					post :create, :event => @attr
				end.should change(Event, :count).by(1)
			end

			it "should redirect to the event show page" do
				post :create, :event => @attr
				response.should redirect_to(event_path(assigns(:event)))
			end   
      
			it "should have a welcome message" do
				post :create, :event => @attr
				flash[:success].should =~ /Event was successfully created./i
			end 
		end
	end
	
	describe "GET 'edit'" do

		before(:each) do
			@event = Factory(:event)
		end

		it "should be successful" do
			get :edit, :id => @event
			response.should be_success
		end

		it "should have the right title" do
			get :edit, :id => @event
			response.should have_selector("title", :content => "Edit Event")
		end
	end
	
	describe "PUT 'update'" do

		before(:each) do
			@event = Factory(:event)
		end

		describe "failure" do

			before(:each) do
				@attr = { 	:title => "", :description => "", :start_date => "",
							:end_date => "", :link_url => "" }
			end

			it "should render the 'edit' page" do
				put :update, :id => @event, :event => @attr
				response.should render_template('edit')
			end

			it "should have the right title" do
				put :update, :id => @event, :event => @attr
				response.should have_selector("title", :content => "Edit Event")
			end
		end

		describe "success" do
	
			before(:each) do
				@attr = { 	:title => "New Event", :description => "This is a new event",
							:start_date => "01/01/2020", :end_date => "02/01/2020", 
							:link_url => "http://www.test.com" }
			end

			it "should change the event's attributes" do
				put :update, :id => @event, :event => @attr
				@event.reload
				@event.title.should  == @attr[:title]
				@event.description.should == @attr[:description]
				@event.link_url.should == @attr[:link_url]
			end

			it "should redirect to the event show page" do
				put :update, :id => @event, :event => @attr
				response.should redirect_to(event_path(@event))
			end

			it "should have a flash message" do
				put :update, :id => @event, :event => @attr
				flash[:success].should =~ /updated/
			end
		end
	end

end
