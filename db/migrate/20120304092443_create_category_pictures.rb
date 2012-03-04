class CreateCategoryPictures < ActiveRecord::Migration
  def change
    create_table :category_pictures do |t|
      t.integer :position
      t.integer :category_id
      t.integer :picture_id
    end

    add_index :category_pictures, [:category_id, :picture_id]
  end
end
