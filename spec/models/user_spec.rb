require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.create(username: "username", email: "email", password: "password" ) }

  it { should have_many(:links) }
  it { should have_many(:comments) }

  it { should validate_presence_of :username }
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of :username }
  it { should validate_uniqueness_of :email }

  describe "#to_s" do
    it "returns the user's username" do
      expect(User.new(username: "Mo").to_s).to eql "Mo"
    end
  end
end
