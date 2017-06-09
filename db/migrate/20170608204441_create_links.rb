class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :user_id, null: false
      t.integer :votes_count, null: false, default: 0
      t.timestamps
    end
    add_foreign_key :links, :users
    add_index :links, :title, unique: true
    add_index :links, :url, unique: true
    add_index :links, :user_id
  end
end
