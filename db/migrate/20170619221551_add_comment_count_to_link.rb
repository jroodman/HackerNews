class AddCommentCountToLink < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :comment_count, :integer, default: 0
  end
end
