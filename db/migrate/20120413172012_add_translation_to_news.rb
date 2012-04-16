class AddTranslationToNews < ActiveRecord::Migration
  def up
    add_column :news, :title_fr, :string
    add_column :news, :title_en, :string
    add_column :news, :content_fr, :text
    add_column :news, :content_en, :text
    remove_column :news, :title
    remove_column :news, :content
  end

  def down
    remove_column :news, :title_fr
    remove_column :news, :title_en
    remove_column :news, :content_fr
    remove_column :news, :content_en
    add_column :news, :title, :string
    add_column :news, :content, :text
  end


end
