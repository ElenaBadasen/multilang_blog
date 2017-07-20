class PostsController < ApplicationController
  def index
    @username = params[:username]
    @posts = Post.all
    @category = Category.find_by(path: params[:category_id])
    @users = User.all
  end

  def new
    @post = Post.new
    @action = :create
    @users = User.all
    render :new_and_edit
  end

  def create
    category = Category.find(params[:category_id])
    @post = category.posts.create(post_params)
    if @post.save
      redirect_to category_posts_path(params[:username], category.path), notice: 'Пост успешно создан'
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
    @users = User.all
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    @post = @category.posts.find(params[:id])
  end

  def edit
    @users = User.all
    @post = Post.find(params[:id])
    @action = :update
    render :new_and_edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Пост успешно изменён.'
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @username = params[:username]
    @post = Post.find(params[:id])
    @post.delete
    redirect_to category_posts_path(@username, @post.category.path), notice: 'Пост успешно удалён.'
  end

  private

  def post_params
    params.require(:post).permit(:name, :content)
  end
end
