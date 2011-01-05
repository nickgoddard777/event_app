require 'spec_helper'

describe Page do
	before (:each) do
		@attr = { :title => "Home", :body => "This a test home page", :page_type=>"home"}
	end
	
	it "should create a new instance given valid attributes" do
		Page.create!(@attr)
	end
	
	it "should require a title" do
		no_title_page = Page.new(@attr.merge(:title => ""))
		no_title_page.should_not be_valid
	end
	
	it "should require a bdy" do
		no_body_page = Page.new(@attr.merge(:body => ""))
		no_body_page.should_not be_valid
	end
	
	it "should require a page_type" do
		no_page_type_page = Page.new(@attr.merge(:page_type => ""))
		no_page_type_page.should_not be_valid
	end
	
	it "should accept a valid page_type" do
		types = %w[home contact about lisavickerage ellenwray]
		types.each do |type|
			valid_type_page = Page.new(@attr.merge(:page_type => type))
			valid_type_page.should be_valid
		end
	end
	
	it "should not accept an invalid page_type" do
		types = %w[fred help]
		types.each do |type|
			invalid_type_page = Page.new(@attr.merge(:page_type => type))
			invalid_type_page.should_not be_valid
		end
	end
	
	it "should reject duplcate page_types" do
		Page.create!(@attr)
		page_with_duplicate_page_type = Page.new(@attr)
		page_with_duplicate_page_type.should_not be_valid
	end
end
