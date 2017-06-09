require 'rails_helper'

RSpec.describe Link, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:votes) }

  describe "#to_s" do
    it "returns the link's title" do
      expect(Link.new(title: "Sample Title").to_s).to eql "Sample Title"
    end
  end
end
