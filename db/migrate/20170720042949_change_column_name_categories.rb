class ChangeColumnNameCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :name, unique: true
    add_index :categories, :path, unique: true
  end
end
