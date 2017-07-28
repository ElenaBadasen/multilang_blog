class AddColorToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :color, :string, default: ""
  end
end
