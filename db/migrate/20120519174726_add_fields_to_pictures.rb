class AddFieldsToPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :price, :float
    add_column :pictures, :selling_price, :float
    remove_column :pictures, :dimensions
    remove_column :pictures, :technic
    remove_column :pictures, :materials

    create_table :picture_informations do |t|
      t.string :name_fr
      t.string :name_en
      t.string :type
    end

    add_column :pictures, :support_id, :integer
    add_column :pictures, :collection_id, :integer
    add_column :pictures, :location_id, :integer
    add_column :pictures, :dimension_id, :integer
    add_column :pictures, :technic_id, :integer
    add_column :pictures, :material_id, :integer

    add_column :pictures, :dimension_extra, :string
    add_column :pictures, :technic_extra, :string
    add_column :pictures, :support_extra, :string
    add_column :pictures, :collection_extra, :string
    add_column :pictures, :material_extra, :string
    add_column :pictures, :location_extra, :string
    add_column :pictures, :personal_note, :text
  end

  def down
    remove_column :pictures, :price
    remove_column :pictures, :selling_price
    add_column :pictures, :dimensions, :string
    add_column :pictures, :technic, :string
    add_column :pictures, :materials, :string

    drop_table :picture_informations

    remove_column :pictures, :support_id
    remove_column :pictures, :collection_id
    remove_column :pictures, :location_id
    remove_column :pictures, :dimension_id
    remove_column :pictures, :technic_id
    remove_column :pictures, :material_id

    remove_column :pictures, :dimension_extra
    remove_column :pictures, :technic_extra
    remove_column :pictures, :support_extra
    remove_column :pictures, :collection_extra
    remove_column :pictures, :material_extra
    remove_column :pictures, :location_extra
    remove_column :picture, :personal_note
  end
end
