class AddColumnToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :profile_message, :text
  end
end
