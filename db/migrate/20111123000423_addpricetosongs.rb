class Addpricetosongs < ActiveRecord::Migration
  def change
    add_column :songs, :price, :float
  end
end
