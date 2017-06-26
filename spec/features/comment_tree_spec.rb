require 'rails_helper'

RSpec.describe "a client interacting with a link's comment index page", type: :feature do

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
      title: 'Test Link1',
      url: 'http://www.testlink.com/',
      user: user
    )
  end

  context "who is authenticated" do

    before do
      login_user User.new(username: 'username123', password: 'password123')
    end

    context "and is attempting to post a new comment on the link" do

      context "with an empty text field" do

        it "is unable to post the comment" do
          visit comments_path(link_id: link.id)
          click_button 'Post Comment'
          expect(page).to have_content "Error: Unable to create comment"
        end

      end

      context "with a filled-in text field" do

        it "is able to post the comment" do
          visit comments_path(link_id: link.id)
          fill_in 'Text', with: 'This is a valid comment'
          click_button 'Post Comment'
          expect(page).to have_content "Comment successfully created"
        end

      end

    end

  end

  context "with multiple, nested comments present in the database" do

    let!(:comment1) do
      Comment.create(
        text: 'Test comment 1',
        link: link,
        user: user
      )
    end

    let!(:comment2) do
      Comment.create(
        text: 'Test comment 2',
        parent_comment_id: comment1.id,
        user: user
      )
    end

    it "is able to view a highest level comment" do
      visit comments_path(link_id: link.id)
      within "div#comment-#{comment1.id}" do
        expect(page).to have_content "Test comment 1"
      end
    end

    it "is able to view a reply-comment" do
      visit comments_path(link_id: link.id)
      within "div#comment-#{comment2.id}" do
        expect(page).to have_content "Test comment 2"
      end
    end

    context "and who is authenticated" do

      before do
        login_user User.new(username: 'username123', password: 'password123')
      end

      context "attempting to reply to a comment" do

        context "with an empty text area" do

          it "is unable to post a reply" do            
            visit new_comment_path(comment_id: comment1)
            click_button 'Post Comment'
            expect(page).to have_content "Error: Unable to create comment"
          end

        end

        context "with a filled text area" do

          it "is able to post a reply" do
            visit new_comment_path(comment_id: comment1)
            fill_in 'Text', with: 'This is a valid comment'
            click_button 'Post Comment'
            expect(page).to have_content "Comment successfully created"
          end

        end

      end

    end

  end

end
