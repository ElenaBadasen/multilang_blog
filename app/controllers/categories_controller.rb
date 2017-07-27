class CategoriesController < ApplicationController
  def index
    @users = User.all
    @username = params[:username]
    @categories = User.find_by(name: @username).categories
    @header_category = @categories.where(destination: "header")[0]
  end

  def new
    @users = User.all
    @username = params[:username]
    @category = Category.new
    @action = :create
    @header_category = @categories.where(destination: "header")[0]
    render :new_and_edit
  end

  def create
    @users = User.all
    @username = params[:username]
    user = User.find_by(name: params[:username])
    @header_category = @categories.where(destination: "header")[0]
    @category = user.categories.create(category_params)
    @category.images << Image.new(file: category_params[:file])
    if @category.save and @category.images[0].save
      redirect_to categories_path, notice: 'Категория успешно создана'
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
    redirect_to categories_path
  end

  def edit
    @users = User.all
    @username = params[:username]
    @user = User.find_by(name: params[:username])
    @category = Category.find(params[:id])
    @action = :update
    @header_category = Category.where(destination: "header")[0]
    render :new_and_edit
  end

  def update
    @users = User.all
    @username = params[:username]
    @category = Category.find(params[:id])
    @header_category = Category.where(destination: "header")[0]
    if category_params[:file].present? or category_params[:file_cache].present?
      @category.images = []
      @category.images << Image.new(file: category_params[:file])
      @category.images[0].save
    end
    if @category.update(category_params) and @category.images[0].save
      redirect_to categories_path, notice: 'Категория успешно изменена.'
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    delete_category = true
    if @category.posts.any?
      delete_category = false
    end
    if delete_category
      @category.delete
      redirect_to categories_path, notice: 'Категория успешно удалена.'
    else
      redirect_to categories_path, notice: 'Нельзя удалить категорию, в которой есть посты.'
    end
  end

  private

  def category_params
    params.require(:category).permit(:picture, :picture_cache, :name, :path, :destination, :description, :user, :file, :file_cache)
  end
end
