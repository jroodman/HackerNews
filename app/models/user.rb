class User < ApplicationRecord

    has_secure_password

    has_many :links
    has_many :comments
    has_many :votes

    validates :username, :email, presence: true, uniqueness: true
    validates :password, length: { in: 8..256 }, if: :password
    validates :username,
      length: { in: 7..50 },
      format: { without: /\s/, message: "must have no whitespace" }

    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "has improper format"}

    validate :password_contains_2_numbers, if: :password

    validates :password_confirmation, presence: true, on: :update, if: :password
    validates :password, presence: true, on: :update, if: :password_confirmation

    def password_contains_2_numbers
      if password.to_s.count("0-9") < 2
        errors.add(:password, "must contain 2 numbers")
      end
    end

    def to_s
      username
    end

end
