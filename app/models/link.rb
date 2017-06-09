class Link < ApplicationRecord

  belongs_to :user

  has_many :votes, as: :votable

  def to_s
    title
  end

end
