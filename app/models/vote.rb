class Vote < ApplicationRecord

  belongs_to :votable, polymorphic: true, counter_cache: true

  validates :user_id, :votable_id, :votable_type, presence: true
  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }

  def to_s
    "#{votable_type}: #{votable_id}"
  end

end
