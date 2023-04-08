class ChangePasswordTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, :string
    add_column :users, :password, :text
  end
end
