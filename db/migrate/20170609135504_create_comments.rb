class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :user_id, null: false
      t.integer :link_id, null: false
      t.integer :parent_comment_id
      t.integer :votes_count, null: false, default: 0
      t.timestamps
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :links
    add_index :comments, :user_id
    add_index :comments, :link_id
    add_index :comments, :parent_comment_id
  end
end
