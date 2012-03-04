class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.has_attached_file :image
      t.string :name
      t.text :description
      t.integer :news_id
      t.timestamps
    end
  end
end
