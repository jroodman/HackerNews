require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "#to_s" do
    it "returns the comment's text" do
      expect(Comment.new(text: "Sample Text").to_s).to eql "Sample Text"
    end
  end
end
