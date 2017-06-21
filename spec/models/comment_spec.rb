require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:link) }
  it { should belong_to(:parent).class_name(:Comment).with_foreign_key(:parent_comment_id) }
  it { should have_many(:children).class_name(:Comment).with_foreign_key(:parent_comment_id) }

  let!(:user) do
    User.create(
      username: 'username123',
      email: 'email@test.com',
      password: 'password123',
      password_confirmation: 'password123'
      )
  end

  let!(:link) do
    Link.create(
      title: 'Test Link',
      url: 'http://www.testlink.com/',
      user: user
    )
  end

  context "validations" do
    it { should validate_presence_of :text }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :votes_count }

    it "should produce error if no parent_comment_id and link_id are present" do
        comment = Comment.new
        comment.text = "Test text"
        expect(comment.valid?).to eq false
        expect(comment.errors[:link_id]).to include "can't be blank"
        expect(comment.errors[:parent_comment_id]).to include "can't be blank"
    end

    it "should be valid if link_id is present and parent_comment_id is not" do
        comment = Comment.new(text: "Test text", link: link, user: user)
        expect(comment.valid?).to eq true
    end

    it "should be valid if parent_comment_id is present and link_id is not" do
        parent_comment = Comment.create(text: "Test text", link: link, user: user)

        comment = Comment.new(text: "Test text", parent: parent_comment, user: user)
        expect(comment.valid?).to eq true
    end

  end

  let!(:first_child_comment) do
    Comment.create(
      text: 'Test text',
      user: user,
      link: link
    )
  end

  describe "#increment_comment_count" do

    it "increments it's parent's comment_count successfully when it's parent is a link" do
      Comment.create(
        text: 'Test text',
        user: user,
        link: link
      )

      expect(link.comment_count).to eq 2
    end

    it "increments it's parent's comment_count successfully when it's parent is a comment" do
      Comment.create(
        text: 'Test text',
        user: user,
        parent: first_child_comment
      )

      expect(link.comment_count).to eq 2
    end

  end

  describe "#decrement_comment_count" do

    it "increments it's parent's comment_count successfully when it's parent is a link" do
      second_child_comment = Comment.create(
        text: 'Test text',
        user: user,
        parent: first_child_comment
      )
      second_child_comment.destroy

      expect(link.comment_count).to eq 1
    end

    it "increments it's parent's comment_count successfully when it's parent is a comment" do
      first_child_comment.destroy

      expect(link.comment_count).to eq 0
    end

  end

  describe "#to_s" do
    it "returns the comment's text" do
      expect(Comment.new(text: "Sample Text").to_s).to eql "Sample Text"
    end
  end
end
