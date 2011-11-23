class Addsongtosong < ActiveRecord::Migration
  def change
    add_column :songs, :song_file_name, :string
    add_column :songs, :song_content_type, :string
    add_column :songs, :song_file_size, :integer
    add_column :songs, :song_updated_at, :datetime
  end
end
