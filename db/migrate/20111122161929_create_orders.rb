class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status
      t.integer :user_id
      t.timestamps
    end
  end
end
