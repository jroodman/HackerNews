class Link < ApplicationRecord

  belongs_to :user

  has_many :votes, as: :votable
  has_many :comments

  validates :title, :url, presence: true, uniqueness: true
  validates :user_id, :votes_count, presence: true

  def to_s
    title
  end

end
