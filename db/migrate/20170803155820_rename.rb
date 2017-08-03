class Rename < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :english_description, :english_content
  end
end
