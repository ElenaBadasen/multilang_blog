class AddDestinationToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :destination, :int, :default => 0, null: false
  end
end
