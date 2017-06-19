require 'rails_helper'

RSpec.describe "a client attempting to submit a link", type: :feature do

  let!(:user) do
    User.create(
      username: 'username123',
      email: 'email@test.com',
      password: 'password123',
      password_confirmation: 'password123'
      )
  end

  before do
    login_user('username123', 'password123')
  end

  context "with empty title and url fields" do

    it "is unable to submit the link" do
      visit new_link_path
      click_button 'Submit'
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Url can't be blank"
    end

  end

  before do
    Link.create(
      title: 'Fake Title',
      url: 'http://www.fakeurl.com/',
      user_id: user.id
    )
  end

  context "with a title and a url that are already taken" do

    it "is unable to submit the link" do
      visit new_link_path
      fill_in 'Title', with: 'Fake Title'
      fill_in 'Url', with: 'http://www.fakeurl.com/'
      click_button 'Submit'
      expect(page).to have_content "Title has already been taken"
      expect(page).to have_content "Url has already been taken"
    end

  end

  context "with a title and a url that are unique" do

    it "is able to submit the link" do
      visit new_link_path
      fill_in 'Title', with: 'Fake (but working) Title'
      fill_in 'Url', with: 'http://www.fakeworkingurl.com/'
      click_button 'Submit'
      expect(page).to have_content "Link successfully submitted"
    end

  end

end
