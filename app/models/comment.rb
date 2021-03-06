class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :link, optional: true
  belongs_to :parent, class_name: :Comment, foreign_key: :parent_comment_id, optional: true

  has_many :votes, as: :votable
  has_many :children, class_name: :Comment, foreign_key: :parent_comment_id

  validates :text, :user_id, :votes_count, presence: true

  validates :link_id, presence: true, unless: :parent_comment_id
  validates :parent_comment_id, presence: true, unless: :link_id

  after_create :modify_comment_count
  after_destroy :modify_comment_count

  def to_s
    text
  end

  def modify_comment_count
    val = destroyed? ? -1 : 1

    if link.present?
      link.update_attributes(comment_count: link.comment_count + val)
    else
      current = parent
      while !current.link.present? do
        current = current.parent
      end
      current.link.update_attributes(comment_count: current.link.comment_count + val)
    end
  end
    
end
