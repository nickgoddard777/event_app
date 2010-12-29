require 'spec_helper'

describe CategoriesController do
	render_views

	describe "GET 'new'" do
		it "should be successful" do
			get :new
			response.should be_success
		end
		
		it "should have the right title" do 
			get :new
			response.should have_selector("title", :content => "New Category")
		end
	end
	
	describe "GET 'show'" do
		
		before(:each) do
			@category = Factory(:category)
		end
		
		it "should be successful" do
			get :show, :id => @category
			response.should be_success
		end
		
		it "should show the category's events" do
			e1 = Factory(:event, :category => @category )
			get :show, :id => @category
			response.should be_success
		end
	end
  
	describe "POST 'create'" do
		describe "failure" do

			before(:each) do
				@attr = { :name => "", :description => "" }
			end

			it "should not create a category" do
				lambda do
					post :create, :category => @attr
					end.should_not change(Category, :count)
			end

			it "should have the right title" do
				post :create, :category => @attr
				response.should have_selector("title", :content => "New Category")
			end

			it "should render the 'new' page" do
				post :create, :category => @attr
				response.should render_template('new')
			end
		end
		
		describe "success" do

			before(:each) do
				@attr = { :name => "New Category", :description => "This is a new category" }
			end
			

			it "should create a category" do
				lambda do
					post :create, :category => @attr
				end.should change(Category, :count).by(1)
			end

			it "should redirect to the category show page" do
				post :create, :category => @attr
				response.should redirect_to(category_path(assigns(:category)))
			end   
      
			it "should have a welcome message" do
				post :create, :category => @attr
				flash[:success].should =~ /Category was successfully created./i
			end 
		end
	end

	describe "GET 'index'" do
		before(:each) do
			@category = Factory(:category)
			@categories = [@category]
			30.times do
				@categories << Factory(:category) 
			end
		end
		
		
		it "should be successful" do
			get 'index'
			response.should be_success
		end
		
		it "should have the right title" do
			get :index
			response.should have_selector("title", :content => "All Categories")
		end
		
		it "should have an element for each category" do
			get :index
			@categories[0..2].each do |category|
				response.should have_selector("li", :content => category.name)
			end
		end
		
		it "should paginate categories" do
			get :index
			response.should have_selector("div.pagination")
			response.should have_selector("span.disabled", :content => "Previous")
			response.should have_selector("a",	:href => "/categories?page=2",
												:content => "2")
			response.should have_selector("a",	:href => "/categories?page=2",
												:content => "Next")
		end
	end

	describe "GET 'edit'" do
		before(:each) do
			@category = Factory(:category)
		end

		it "should be successful" do
			get :edit, :id => @category
			response.should be_success
		end

		it "should have the right title" do
			get :edit, :id => @category
			response.should have_selector("title", :content => "Edit Category")
		end
	end
	
	describe "PUT 'update'" do

		before(:each) do
			@category = Factory(:category)
		end

		describe "failure" do

			before(:each) do
				@attr = { 	:name => "", :description => "" }
			end

			it "should render the 'edit' page" do
				put :update, :id => @category, :category => @attr
				response.should render_template('edit')
			end

			it "should have the right title" do
				put :update, :id => @category, :category => @attr
				response.should have_selector("title", :content => "Edit Category")
			end
		end

		describe "success" do
	
			before(:each) do
				@attr = { :name => "Test Category", :description => "This is a new category" }
			end

			it "should change the category's attributes" do
				put :update, :id => @category, :category => @attr
				@category.reload
				@category.name.should  == @attr[:name]
				@category.description.should == @attr[:description]
			end

			it "should redirect to the category show page" do
				put :update, :id => @category, :category => @attr
				response.should redirect_to(category_path(@category))
			end

			it "should have a flash message" do
				put :update, :id => @category, :category => @attr
				flash[:success].should =~ /updated/
			end
		end
	end
end
