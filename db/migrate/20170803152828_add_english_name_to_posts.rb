class AddEnglishNameToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :english_name, :string
  end
end
