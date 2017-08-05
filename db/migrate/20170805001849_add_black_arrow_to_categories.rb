class AddBlackArrowToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :black_arrow, :boolean, :default => false
  end
end
