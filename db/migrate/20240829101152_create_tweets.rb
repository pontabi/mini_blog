class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.references :parent, foreign_key: { to_table: :tweets }
      t.integer :likes_count, default: 0
      t.integer :replies_count, default: 0

      t.timestamps

      t.index :created_at
      t.index [ :user_id, :created_at ]
    end
  end
end
