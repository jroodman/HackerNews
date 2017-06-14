require 'rails_helper'

RSpec.describe "a client attempting to create a new user", type: :feature do

  context "with an empty username field" do

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Email', with: 'email2@test.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content "Username can't be blank"
    end

  end

  context "with an empty email field" do

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content "Email can't be blank"
    end

  end

  context "with an empty password field" do

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Email', with: 'email@test.com'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content "Password can't be blank"
    end

  end

  context "with an empty password confirmation field" do

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Email', with: 'email@test.com'
      fill_in 'Password', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content "Password confirmation doesn't match"
    end

  end

  context "with a username that is already in the database" do

    before do
      User.create(
        username: 'username123',
        email: 'email@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Email', with: 'email2@test.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content 'Username has already been taken'
    end

  end

  context "with an email that is already in the database" do

    before do
      User.create(
        username: 'username1234',
        email: 'email@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    it "is unable to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Email', with: 'email@test.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content 'Email has already been taken'
    end

  end

  context 'with complete information fields' do

    it "is able to create the new account" do
      visit new_user_path
      fill_in 'Username', with: 'username123'
      fill_in 'Email', with: 'email@test.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'
      click_button 'Submit'
      expect(page).to have_content 'User successfully created'
    end

  end
  
end
