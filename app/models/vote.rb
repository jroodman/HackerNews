class Vote < ApplicationRecord

  belongs_to :votable, polymorphic: true

  validates :user_id, :votable_id, :votable_type, presence: true

  def to_s
    "#{votable_type}: #{votable_id}"
  end

end
