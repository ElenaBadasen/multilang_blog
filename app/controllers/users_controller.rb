class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    authorize! :create, User
    @user = User.new
    @action = :create
    @password_correct = true
    render :new_and_edit
  end

  def create
    authorize! :create, User
    @user = User.create(user_params)
    @user.member = true
    @password_correct = true


    if user_params[:file].present?
      @user.images << Image.new(file: user_params[:file])
    end
    if @user.save and @user.images[0].save
      redirect_to users_path, notice: t('user_created')
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
    @action = :update
    @password_correct = true
    render :new_and_edit
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if user_params[:file].present?
      @user.images = []
      @user.images << Image.new(file: user_params[:file])
      @user.images[0].save
    end
    @user.name = user_params[:name]
    @user.email = user_params[:email]
    @user.custom_css = user_params[:custom_css]
    @user.member = true
    @password_correct = true
    if params[:password].present?
      if @user.authenticate(params[:current_password]) == false
        @password_correct = false
      else
        @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
      end
    end
    if @user.save and @user.images[0].save and @password_correct
      redirect_to users_path, notice: t('user_modified')
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    delete_user = true
    if @user.categories.any?
      delete_user = false
    end
    if delete_user
      @user.delete
      redirect_to users_path, notice: t('user_deleted')
    else
      redirect_to users_path, notice: t('cannot_delete_user')
    end
  end

  private

  def user_params
    params.require(:user).permit(:file, :file_cache, :name, :email, :custom_css, :password, :password_confirmation)
  end

end
