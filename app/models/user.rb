class User < ApplicationRecord

    has_secure_password
    has_many :links
    has_many :comments

    validates :username, :email, presence: true, uniqueness: true
    validates :password, presence: true

    def to_s
      username
    end

end
