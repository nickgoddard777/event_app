class PagesController < ApplicationController
	before_filter :authenticate_admin!, :except => [:show]
	
	def index
		@title = "All Pages"
		@pages = Page.all
	end

	def show
  		@page = Page.find(params[:id])
		@title = @page.title
	end

	def new
		@title = "New Page"
		@page = Page.new
	end

	def create
		@page = Page.new(params[:page])
		if @page.save
			flash[:success] = "Page was successfully created."
			redirect_to @page
		else
			@title = "New Page"
			render 'new'
		end
	end

	def edit
		@title = "Edit Page"
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])
			flash[:success] = "Page updated."
			redirect_to @page
		else
			@title = "Edit Page"
			render 'edit'
		end
	end

	def destroy
	end
	
	def home
		@title = "Home"
		@page = Page.find_by_page_type("home")
		render 'show'
	end
	
	def contact
		@title = "Contact Us"
		@page = Page.find_by_page_type("contact")
		render 'show'
	end
end
