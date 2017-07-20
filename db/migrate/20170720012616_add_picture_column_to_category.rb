class AddPictureColumnToCategory < ActiveRecord::Migration[5.0]
  def up
    add_attachment :categories, :picture
  end

  def down
    remove_attachment :categories, :picture
  end
end
