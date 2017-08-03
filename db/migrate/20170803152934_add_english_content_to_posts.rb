class AddEnglishContentToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :english_description, :text
  end
end
