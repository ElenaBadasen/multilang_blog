class DeleteColumnsFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :picture_file_name
    remove_column :categories, :picture_content_type
    remove_column :categories, :picture_file_size
    remove_column :categories, :picture_updated_at
  end
end
