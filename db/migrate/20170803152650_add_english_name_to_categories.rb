class AddEnglishNameToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :english_name, :string
  end
end
