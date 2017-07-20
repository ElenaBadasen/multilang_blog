class CategoriesController < ApplicationController
  def index
    @users = User.all
    @username = params[:username]
    @categories = User.find_by(name: @username).categories
  end

  def new
    @users = User.all
    @category = Category.new
    @action = :create
    render :new_and_edit
  end

  def create
    user = User.find_by(name: params[:username])
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
    @users = User.all
    @username = params[:username]
    @category = Category.find_by(path: params[:id])
  end

  def edit
    @users = User.all
    @user = User.find_by(name: params[:username])
    @category = Category.find(params[:id])
    @action = :update
    render :new_and_edit
  end

  def update
    @category = Category.find(params[:id])
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
    params.require(:category).permit(:picture, :picture_cache, :name, :path, :description, :user, :file, :file_cache)
  end
end
