class AddPriorityToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :priority, :integer, default: 0
  end
end
