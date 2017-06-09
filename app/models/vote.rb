class Vote < ApplicationRecord

  belongs_to :votable, polymorphic: true

  def to_s
    "#{votable_type}: #{votable_id}"
  end

end
