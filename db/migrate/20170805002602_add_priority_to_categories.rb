class AddPriorityToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :priority, :integer, default: 0
  end
end
