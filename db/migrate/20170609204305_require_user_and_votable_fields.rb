class RequireUserAndVotableFields < ActiveRecord::Migration[5.1]
  def up
    change_column :votes, :user_id, :integer, null: false
    change_column :votes, :votable_id, :integer, null: false
    change_column :votes, :votable_type, :string, null: false
  end
  def down
    change_column :votes, :user_id, :integer, null: true
    change_column :votes, :votable_id, :integer, null: true
    change_column :votes, :votable_type, :string, null: true
  end
end
