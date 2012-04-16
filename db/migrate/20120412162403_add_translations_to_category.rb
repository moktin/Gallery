class AddTranslationsToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :name_fr, :string
    add_column :categories, :name_en, :string
    remove_column :categories, :name
  end

  def self.down
    remove_column :categories, :name_fr
    remove_column :categories, :name_en
    add_column :categories, :name, :string
  end
end
