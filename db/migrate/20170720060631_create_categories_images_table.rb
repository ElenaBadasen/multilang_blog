class CreateCategoriesImagesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_images do |t|
      t.belongs_to :category, index: true
      t.belongs_to :image, index: true
    end
  end
end
