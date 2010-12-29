require 'spec_helper'

describe Category do
	before (:each) do
		@attr = { :name => "Test Category", :description => "This a description of a test category"}
	end
	
	it "should create a new instance given valid attributes" do
		Category.create!(@attr)
	end
	
	it "should require a name" do
		no_title_category = Category.new(@attr.merge(:name => ""))
		no_title_category.should_not be_valid
	end
	
	it "should reject duplicate names" do
		Category.create!(@attr)
		category_with_duplicate_name = Category.new(@attr)
		category_with_duplicate_name.should_not be_valid
	end
	
	it "should reject names identical up to case" do
		upcased_name = @attr[:name].upcase
		Category.create!(@attr.merge(:name => upcased_name))
		category_with_duplicate_name = Category.new(@attr)
		category_with_duplicate_name.should_not be_valid
	end
	
	it "should required a description" do
		no_description_category = Category.new(@attr.merge(:description =>""))
		no_description_category.should_not be_valid
	end
	
	describe "event associations" do
		before(:each) do
			@category = Category.create(@attr)
		end
		
		it "should have a events attribute" do
			@category.should respond_to(:events)
		end
	end
end
 