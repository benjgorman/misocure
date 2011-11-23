class Addphototoalbums < ActiveRecord::Migration
  def change
    add_column :albums, :photo_file_name, :string
    add_column :albums, :photo_content_type, :string
    add_column :albums, :photo_file_size, :integer
    add_column :albums, :photo_updated_at, :datetime
  end
end
