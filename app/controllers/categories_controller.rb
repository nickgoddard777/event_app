class CategoriesController < ApplicationController
	def index
		@title = "All Categories"
		@categories = Category.paginate(:page => params[:page])
	end

	def show
  		@category = Category.find(params[:id])
  		@events = @category.events.paginate(:page => params[:page])
		@title = @category.name
	end

	def edit
		@category = Category.find(params[:id])
		@title = "Edit Category"
	end
	
	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			flash[:success] = "Category updated."
			redirect_to @category
		else
			@title = "Edit Category"
			render 'edit'
		end
	end
	
	def new
		@category = Category.new
		@title = "New Category"
	end
	
	def create
		@category = Category.new(params[:category])
		if @category.save
			flash[:success] = "Category was successfully created."
			redirect_to @category
		else
			@title = "New Category"
			render 'new'
		end
	end

	

end
