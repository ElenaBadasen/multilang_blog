class ImagesController < ApplicationController
  def index
    @users = User.all
    @images = Image.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @users = User.all
    @image = Image.new
    @action = :create
    render :new
  end

  def create
    @users = User.all
    @image = Image.create(image_params)
    @image.file = image_params[:file]
    if @image.save
      redirect_to image_path(@image.id), notice: 'Изображение успешно загружено'
    else
      @action = :create
      render :new
    end
  end

  def show
    @users = User.all
    @image = Image.find(params[:id])
  end

  def edit
    @users = User.all
  end

  def update
    @users = User.all
  end

  def destroy
    @image = Image.find(params[:id])
    delete_image = true
    Category.all.each do |cat|
      cat.images.each do |i|
        if i == @image
          delete_image = false
        end
      end
    end
    if delete_image
      User.all.each do |u|
        u.images.each do |i|
          if i == @image
            delete_image = false
          end
        end
      end
    end

    if delete_image
      @image.delete
      redirect_to images_path, notice: 'Изображение успешно удалено.'
    else
      redirect_to images_path, notice: 'Нельзя удалить изображение, которое используется как аватар или картинка категории.'
    end
  end

  private

  def image_params
    params.require(:image).permit(:file, :file_cache)
  end
end
