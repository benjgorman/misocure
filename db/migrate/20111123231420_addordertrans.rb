class Addordertrans < ActiveRecord::Migration
   def change
    create_table :order_transactions do |t|
      t.integer :payment_id
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps
    end
   end
end
