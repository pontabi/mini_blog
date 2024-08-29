class AddUsernameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :username, :string, null: false, after: :email
    add_index :users, :username, unique: true
  end
end
