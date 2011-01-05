require 'spec_helper'

describe PagesController do
	render_views
	
	describe "as guest" do
		
		describe "GET 'home'" do
			before(:each) do
				@page = Factory(:page)
			end
		
			it "should be successful" do
				get :home
				response.should be_success
			end
			
		#	it "should have the right title" do
		#		get :home
		#		response.should have_selector("title", :content => "Home")
		#	end
			
		#	it "should render the 'show' page" do
		#		get :home, :page => @page
		#		response.should render_template('show')
		#	end
		end
		
		describe "GET 'contact'" do
			before(:each) do
				@page = Factory(:page, :page_type => "contact")
			end

			it "should be successful" do
				get :contact
				response.should be_success
			end

			 it "should find the right user" do
				get :contact
				assigns(:page).should == @page
			end

		end
		
		describe "GET 'about'" do
			pending "add some examples to (or delete) #{__FILE__}"
		end
		
		describe "GET 'lisavickerage'" do
			pending "add some examples to (or delete) #{__FILE__}"			
		end
		
		describe "GET 'ellenwray'" do
			pending "add some examples to (or delete) #{__FILE__}"
		end

		describe "GET 'show'" do
			before(:each) do
				@page = Factory(:page)
			end
		
			it "should be successful" do
				get :show, :id => @page
				response.should be_success
			end

			 it "should find the right user" do
				get :contact, :id => @page
				assigns(:page).should == @page
			end
		end
 	end
 	
 	describe "as admin" do
		
		before(:each) do
			@user = Factory.create(:admin)
			sign_in @user
		end
		
		describe "GET 'index'" do
			before(:each) do
				@page = Factory(:page)
				@pages = [@page]
				@pages << Factory(:page, :page_type => "contact") 
				@pages << Factory(:page, :page_type => "about")
				@pages << Factory(:page, :page_type => "lisavickerage")
				@pages << Factory(:page, :page_type => "ellenwray")
			end
		
			it "should be successful" do
				get 'index'
				response.should be_success
			end
		
			it "should have the right title" do
				get :index
				response.should have_selector("title", :content => "All Pages")
			end
		
			it "should have an element for each page" do
				get :index
				@pages[0..2].each do |page|
					response.should have_selector("li", :content => @page.title)
				end
			end
		end

		describe "GET 'new'" do
			it "should be successful" do
				get :new
				response.should be_success
			end
		
			it "should have the right title" do 
				get :new
				response.should have_selector("title", :content => "New Page")
			end
		end

		describe "GET 'create'" do
			describe "failure" do
				before(:each) do
					@attr = { :title => "", :body => "", :page_type => "" }
				end

				it "should not create a page" do
					lambda do
						post :create, :page => @attr
					end.should_not change(Page, :count)
				end

				it "should have the right title" do
					post :create, :page => @attr
					response.should have_selector("title", :content => "New Page")
				end

				it "should render the 'new' page" do
					post :create, :page => @attr
					response.should render_template('new')
				end
			end
		
			describe "success" do

				before(:each) do
					@attr = { :title => "New Page", :body => "This is a new page", :page_type => "contact" }
				end
			

				it "should create a page" do
					lambda do
						post :create, :page => @attr
					end.should change(Page, :count).by(1)
				end

				it "should redirect to the page show page" do
					post :create, :page => @attr
					response.should redirect_to(page_path(assigns(:page)))
				end   
      
				it "should have a welcome message" do
					post :create, :page => @attr
					flash[:success].should =~ /Page was successfully created./i
				end 
			end
		end

		describe "GET 'edit'" do
			before(:each) do
				@page = Factory(:page)
			end

			it "should be successful" do
				get :edit, :id => @page
				response.should be_success
			end

			it "should have the right title" do
				get :edit, :id => @page
				response.should have_selector("title", :content => "Edit Page")
			end
		end

		describe "GET 'update'" do

			before(:each) do
				@page = Factory(:page)
			end

			describe "failure" do

				before(:each) do
					@attr = { :title => "", :body => "", :page_type => "" }
				end

				it "should render the 'edit' page" do
					put :update, :id => @page, :page => @attr
					response.should render_template('edit')
				end

				it "should have the right title" do
					put :update, :id => @page, :page => @attr
					response.should have_selector("title", :content => "Edit Page")
				end
			end

			describe "success" do
	
				before(:each) do
					@attr = { :title => "Test Page", :body => "This is an edited page", :page_type =>"about" }
				end

				it "should change the page's attributes" do
					put :update, :id => @page, :page => @attr
					@page.reload
					@page.title.should  == @attr[:title]
					@page.body.should == @attr[:body]
					@page.page_type.should == @attr[:page_type]
				end

				it "should redirect to the page show page" do
					put :update, :id => @page, :page => @attr
					response.should redirect_to(page_path(@page))
				end

				it "should have a flash message" do
					put :update, :id => @page, :page => @attr
					flash[:success].should =~ /updated/
				end
			end
		end

		describe "GET 'destroy'" do
		end
	end
end
