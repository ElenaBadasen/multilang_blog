class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @action = :create
    @password_correct = true
    render :new_and_edit
  end

  def create
    @user = User.create(user_params)
    @password_correct = true

    @user.images << Image.new
    @user.images[0].file = user_params[:file]
    if @user.save and @user.images[0].save
      redirect_to users_path, notice: 'Пользователь успешно создан'
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    @action = :update
    @password_correct = true
    render :new_and_edit
  end

  def update
    @user = User.find(params[:id])
    if user_params[:file].present?
      @user.images = []
      @user.images << Image.new
      @user.images[0].file = user_params[:file]
      @user.images[0].save
    end
    @user.name = user_params[:name]
    @password_correct = true
    if params[:password].present?
      if @user.authenticate(params[:current_password]) == false
        @password_correct = false
      else
        @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
      end
    end
    if @user.save and @user.images[0].save and @password_correct
      redirect_to users_path, notice: 'Пользователь успешно изменён.'
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    delete_user = true
    if @user.categories.any?
      delete_user = false
    end
    if delete_user
      @user.delete
      redirect_to users_path, notice: 'Пользователь успешно удалён.'
    else
      redirect_to users_path, notice: 'Нельзя удалить пользователя, у которого есть категории.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:file, :file_cache, :name, :email, :password, :password_confirmation)
  end

end
