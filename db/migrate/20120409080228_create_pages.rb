class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.string :slug
      t.integer :position
      t.boolean :online, :default => false
      t.timestamps
    end

    add_index :pages, :slug
    add_index :pages, :online
  end
end
