require 'spec_helper'

describe Event do
	before (:each) do
		@category = Factory(:category)
		@attr = { :title => "Test Event", :description => "This a description of a test event", :start_date => "29/05/2011", :end_date => "31/05/2011", :link_url => "http://www.testevent.co.uk"}
	end
	
	it "should create a new instance given valid attributes" do
		@category.events.create!(@attr)
	end
	
	it "should require a title" do
		no_title_event = Event.new(@attr.merge(:title => ""))
		no_title_event.should_not be_valid
	end
	
	it "should required a description" do
		no_description_event = Event.new(@attr.merge(:description =>""))
		no_description_event.should_not be_valid
	end
	
	it "should require a start_date after today" do
		early_start_date_event = Event.new(@attr.merge(:start_date => Date.yesterday))
		early_start_date_event.should_not be_valid
	end
	
	it "should require an end_date after the start_date" do
		early_end_date_event = Event.new(@attr.merge(:end_date => "29/05/2011"))
		early_end_date_event.should_not be_valid
	end
	
	it "should accept a valid link url" do
		urls = %w[http://www.test.com http://test.org.uk]
		urls.each do |url|
			valid_url_event = Event.new(@attr.merge(:link_url => url))
			valid_url_event.should be_valid
		end
	end
	
	it "should reject an invalid link url" do
		urls = %w[www.test.com]
		urls.each do |url|
			valid_url_event = Event.new(@attr.merge(:link_url => url))
			valid_url_event.should_not be_valid
		end
	end
	
	describe "category associations" do
		before(:each) do
			@event = @category.events.create(@attr)
		end
		
		it "should have a category attribute" do
			@event.should respond_to(:category)
		end
		
		it "should have the right associated category" do
			@event.category_id.should == @category.id
			@event.category.should  == @category
		end
	end
end
