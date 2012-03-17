class AddFiedsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :dimensions, :string
    add_column :pictures, :technic, :string
    add_column :pictures, :materials, :string
    add_column :pictures, :year, :date
  end
end
