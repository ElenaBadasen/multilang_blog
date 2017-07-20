class AddColumnPathToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :path, :string, :null => false, :uniq => true, :default => "path"
  end
end
