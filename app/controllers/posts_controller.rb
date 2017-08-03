class PostsController < ApplicationController
  def index
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    @posts = @category.posts
    @users = User.all
  end

  def new
    authorize! :create, Post
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    authorize! :update, @category
    @post = Post.new
    @action = :create
    @users = User.all
    render :new_and_edit
  end

  def create
    authorize! :create, Post
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    authorize! :update, @category
    @post = @category.posts.create(post_params)
    if @post.save
      redirect_to category_posts_path(params[:username], @category.path), notice: t('post_created')
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
    @users = User.all
    @username = params[:username]
    @post = Post.find(params[:id])
    @category = @post.category
  end

  def edit
    @username = params[:username]
    @users = User.all
    @post = Post.find(params[:id])
    authorize! :update, @post
    @category = @post.category
    @action = :update
    render :new_and_edit
  end

  def update
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    @post = Post.find(params[:id])
    authorize! :update, @post
    if @post.update(post_params)
      redirect_to post_path(params[:username], @post), notice: t('post_modified')
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @username = params[:username]
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.delete
    redirect_to category_posts_path(@username, @post.category.path), notice: t('post_deleted')
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :english_name, :english_content)
  end
end
