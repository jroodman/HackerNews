require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.create(username: "username123", email: "email@test.com", password: "password123" ) }

  it { should have_many(:links) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }

  it { should validate_presence_of :username }
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  it { should validate_length_of(:username).is_at_least(7).is_at_most(50) }
  it { should validate_length_of(:password).is_at_least(8).is_at_most(256) }

  it { should allow_value('email@test.com').for(:email) }
  it { should allow_value('username').for(:username) }
  it { should allow_value('password12').for(:password) }
  it { should_not allow_value('email').for(:email) }
  it { should_not allow_value('email@test').for(:email) }
  it { should_not allow_value('password').for(:password) }
  it { should_not allow_value('password1').for(:password) }
  it { should_not allow_value('username space').for(:username) }


  describe "#to_s" do
    it "returns the user's username" do
      expect(User.new(username: "Mo").to_s).to eql "Mo"
    end
  end
end
