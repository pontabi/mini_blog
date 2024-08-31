class CreateUserBlogs < ActiveRecord::Migration[7.2]
  def change
    create_table :user_blogs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.string :kind

      t.timestamps
    end
  end
end
