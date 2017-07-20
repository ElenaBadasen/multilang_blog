class CategoriesController < ApplicationController
  def index
    @username = params[:username]
    @categories = Category.all
  end

  def new
    @category = Category.new
    @action = :create
    render :new_and_edit
  end

  def create
    user = User.find_by(name: params[:username])
    @category = user.categories.create(category_params)
    @category.images << Image.new
    @category.images[0].file = category_params[:file]
    if @category.save and @category.images[0].save
      redirect_to categories_path, notice: 'Категория успешно создана'
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
  end

  def edit
    @user = User.find_by(name: params[:username])
    @category = Category.find(params[:id])
    @action = :update
    render :new_and_edit
  end

  def update
    @category = Category.find(params[:id])
    p "HERE", category_params[:file], category_params[:file_cache]
    p @category
    if category_params[:file].present? or category_params[:file_cache].present?
      p "HERE1"
      @category.images = []
      @category.images << Image.new
      @category.images[0].file = category_params[:file].present? ? category_params[:file] : category_params[:file_cache]
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
