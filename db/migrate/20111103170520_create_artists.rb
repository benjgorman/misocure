class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.text :bio
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
