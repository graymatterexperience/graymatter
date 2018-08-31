class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :auther_id, null: false
      t.string :user_tags, array: true

      t.timestamps
    end
  end
end
