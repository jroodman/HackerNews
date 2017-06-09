class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :parent, class_name: :Comment, foreign_key: :parent_comment_id

  has_many :votes, as: :votable
  has_many :children, class_name: :Comment, foreign_key: :parent_comment_id

  def to_s
    text
  end

end
