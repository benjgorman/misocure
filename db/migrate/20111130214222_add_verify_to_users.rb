class AddVerifyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verify_token, :string
    add_column :users, :status, :integer
  end
end
