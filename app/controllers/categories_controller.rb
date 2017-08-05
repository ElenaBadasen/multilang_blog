class CategoriesController < ApplicationController
  def index
    @users = User.all
    @username = params[:username]
    @user = User.find_by(name: @username)
    unless @user.present?
      raise ActionController::RoutingError.new('Not Found')
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
    image = Image.create(file: category_params[:file])
    if image.valid?
      @category.images << image
    end
    if @category.save
      redirect_to category_posts_path(@username, @category.path), notice: t('category_successfully_created')
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
    if category_params[:file].present?
      @category.images = []
      image = Image.create(file: category_params[:file])
      if image.valid?
        @category.images << image
      end
    end
    if @category.update(category_params)
      redirect_to category_posts_path(@username, @category.path), notice: t('category_successfully_modified')
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
                                     :english_name, :english_description, :user, :file, :file_cache, :black_arrow, :priority)
  end
end
