class AddFieldsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :support, :string
    add_column :pictures, :collection, :string
    add_column :pictures, :price, :float
    add_column :pictures, :selling_price, :float
    add_column :pictures, :location, :string
  end
end
