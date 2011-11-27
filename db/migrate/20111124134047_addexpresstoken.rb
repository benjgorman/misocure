class Addexpresstoken < ActiveRecord::Migration
  def change
    add_column :payments, :express_token, :string
    add_column :payments, :express_payer_id, :string
  end
end
