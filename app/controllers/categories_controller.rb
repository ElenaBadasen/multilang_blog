class CategoriesController < ApplicationController
  def index
    @users = User.all
    @username = params[:username]
    @user = User.find_by(name: @username)
    unless @user.present?
      redirect_to errors_not_found_url
      return
    end
    @categories = @user.categories
    @header_category = @categories.where(destination: "header")[0]
  end

  def new
    authorize! :create, Category
    @users = User.all
    @username = params[:username]
    @user = User.find_by(name: @username)
    authorize! :update, @user
    @category = Category.new
    @action = :create
    @header_category = @user.categories.where(destination: "header")[0]
    render :new_and_edit
  end

  def create
    authorize! :create, Category
    @users = User.all
    @username = params[:username]
    user = User.find_by(name: params[:username])
    authorize! :update, user
    @header_category = user.categories.where(destination: "header")[0]
    @category = user.categories.create(category_params)
    @category.images << Image.new(file: category_params[:file])
    if @category.save and @category.images[0].save
      redirect_to categories_path, notice: t('category_successfully_created')
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
    authorize! :update, @category
    @action = :update
    @header_category = @user.categories.where(destination: "header")[0]
    render :new_and_edit
  end

  def update
    @users = User.all
    @username = params[:username]
    @category = Category.find(params[:id])
    authorize! :update, @category
    @user = User.find_by(name: params[:username])
    @header_category = @user.categories.where(destination: "header")[0]
    if category_params[:file].present? or category_params[:file_cache].present?
      @category.images = []
      @category.images << Image.new(file: category_params[:file])
      @category.images[0].save
    end
    if @category.update(category_params) and @category.images[0].save
      redirect_to categories_path, notice: t('category_successfully_modified')
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize! :destroy, @category
    delete_category = true
    if @category.posts.any?
      delete_category = false
    end
    if delete_category
      @category.delete
      redirect_to categories_path, notice: t('category_successfully_deleted')
    else
      redirect_to categories_path, notice: t('cannot_delete_category_with_posts')
    end
  end

  private

  def category_params
    params.require(:category).permit(:picture, :picture_cache, :name, :color, :path, :destination, :description,
                                     :english_name, :english_description, :user, :file, :file_cache)
  end
end
