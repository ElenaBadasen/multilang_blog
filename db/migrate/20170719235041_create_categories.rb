class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :image_id

      t.timestamps
    end
  end
end
