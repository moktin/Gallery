class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.date :start_at
      t.date :end_at
      t.timestamps
    end
  end
end
