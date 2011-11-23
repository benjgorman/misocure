class Addtimefieldtophoto < ActiveRecord::Migration
  def change
    add_column :artists, :photo_updated_at, :datetime
  end
end
