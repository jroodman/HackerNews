require 'rails_helper'

RSpec.describe "a client attempting to vote on a link", type: :feature do

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

  context "who is not authenticated" do

    it "is unable to vote" do
      visit root_path
      expect(page.find("#false-link").present?).to eq true
    end

  end

  context "who is authenticated" do

    before do
      login_user
    end

    context "and has not voted on the link before" do

      it "has their vote applied" do
        visit root_path
        within "li#link-#{link.id}" do
          page.find(".up-vote-link").click()
          expect(page).to have_content "1"
        end
      end

    end

    context "and has already voted on the link" do

      before do
        visit root_path
        within "li#link-#{link.id}" do
          page.find(".up-vote-link").click()
        end
      end

      it "has their vote removed" do
        visit root_path
        within "li#link-#{link.id}" do
          page.find(".down-vote-link").click()
          expect(page).to have_content "0"
        end
      end

    end

  end

end
