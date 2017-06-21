class ModifyCommentsToRemoveRequiredLinkParent < ActiveRecord::Migration[5.1]
  def up
    change_column :comments, :link_id, :integer, null: true
  end
  def down
    change_column :comments, :link_id, :integer, null: false
  end
end
