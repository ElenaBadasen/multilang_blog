class PostsController < ApplicationController
  def index
    @username = params[:username]
    @posts = Post.all
    @category = Category.find_by(path: params[:category_id])
  end

  def new
    @post = Post.new
    @action = :create
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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:name, :content)
  end
end
