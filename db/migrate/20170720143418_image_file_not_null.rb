class ImageFileNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :images, :file, false
  end
end
