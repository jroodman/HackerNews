class User < ApplicationRecord

    has_secure_password
    has_many :links
    has_many :comments

    validates :username, :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :username, length: { in: 7..50 }
    validates :password, length: { in: 8..256 }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "has improper format"}
    validates :username, format: { without: /\s/, message: "must have no whitespace" }
    validate :password_contains_2_numbers

    def password_contains_2_numbers
      if password.to_s.count("0-9") < 2
        errors.add(:password, "must contain 2 numbers")
      end
    end

    def to_s
      username
    end

end
