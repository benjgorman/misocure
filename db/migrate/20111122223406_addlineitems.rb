class Addlineitems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :song_id
      t.timestamps
    end
  end
end