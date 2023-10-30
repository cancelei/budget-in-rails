class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :verify_category_owner, only: [:show, :edit, :update, :destroy]

  def index
    @categories = current_user.categories.includes(:operations)
  end

  # Show individual category details along with its operations
  def show
    @category = Category.find(params[:id])
    @operations = @category.operations
  end

  def new
    @category = Category.new
  end
  
  # Create new category
  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end
  
  # (Optional) Edit category form
  def edit
    @category = Category.find(params[:id])
  end
  
  # (Optional) Update category
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category updated successfully.'
    else
      render :edit
    end
  end
  
  # (Optional) Delete category
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  
  def verify_category_owner
    unless @category.user_id == current_user.id
      redirect_to categories_path, alert: 'You do not have permission to access this resource.'
    end
end
end