class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.text :email, null: false
      t.text :encrypted_password, limit: 128, null: false
      t.text :confirmation_token, limit: 128
      t.text :remember_token, limit: 128, null: false
      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :confirmation_token, unique: true
    add_index :users, :remember_token, unique: true
  end
end
