class RemoveUniqueConstraintFromPathCategories < ActiveRecord::Migration[5.0]
  def change
    remove_index :categories, :path
  end
end
