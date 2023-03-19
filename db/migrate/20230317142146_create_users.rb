class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
    
      t.string :name
      t.string :email
      t.string :password
      t.string :session_token
      t.integer :status
      t.integer :role
      t.datetime :last_logged_in
      t.timestamps
    end
  end
end
