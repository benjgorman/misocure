class AddPhotoToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :photo_file_name, :string
    add_column :artists, :photo_content_type, :string
    add_column :artists, :photo_file_size, :integer
  end
end
