class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|

      t.integer :user_id
      t.text :content
      t.integer :approved_by
      t.timestamps
    end
    remove_column :users, :name
  end
end
