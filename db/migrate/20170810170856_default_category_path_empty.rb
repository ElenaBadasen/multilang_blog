class DefaultCategoryPathEmpty < ActiveRecord::Migration[5.0]
  def change
    change_column :categories, :path, :string, default: ""
  end
end
