class AddEnglishDescriptionToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :english_description, :text
  end
end
