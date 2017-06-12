require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:link) }
  it { should belong_to(:parent).class_name(:Comment).with_foreign_key(:parent_comment_id) }
  it { should have_many(:children).class_name(:Comment).with_foreign_key(:parent_comment_id) }

  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :link_id }
  it { should validate_presence_of :votes_count }

  describe "#to_s" do
    it "returns the comment's text" do
      expect(Comment.new(text: "Sample Text").to_s).to eql "Sample Text"
    end
  end
end
