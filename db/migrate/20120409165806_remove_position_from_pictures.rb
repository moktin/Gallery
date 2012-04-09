class RemovePositionFromPictures < ActiveRecord::Migration
  def up
    remove_column :pictures, :position
  end

  def down
    add_column :pictures, :position, :integer
  end
end
