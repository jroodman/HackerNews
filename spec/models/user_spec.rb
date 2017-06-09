require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:links) }
  it { should have_many(:comments) }
  
  describe "#to_s" do
    it "returns the user's username" do
      expect(User.new(username: "Mo").to_s).to eql "Mo"
    end
  end
end
