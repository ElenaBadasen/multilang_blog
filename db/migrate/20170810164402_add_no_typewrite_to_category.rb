class AddNoTypewriteToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :no_typewrite, :boolean, :default => false
  end
end
