class CategoriesNameNullTrue < ActiveRecord::Migration[5.0]
  def change
    change_column :categories, :name, :string, :null => true
  end
end
