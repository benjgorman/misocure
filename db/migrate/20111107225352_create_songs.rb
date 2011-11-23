class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :artist_id
      t.string :name
      t.string :album_name
      t.string :album_id
      t.integer :genre_id
      

      t.timestamps
    end
  end
end
