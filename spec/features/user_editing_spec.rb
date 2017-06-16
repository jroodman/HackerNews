require 'rails_helper'

RSpec.describe "a client attempting to edit their acccount", type: :feature do

  let!(:user) do
    User.create(
      username: 'username123',
      email: 'email@test.com',
      password: 'password123',
      password_confirmation: 'password123'
      )
  end

  context "with all fields empty" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Username', with: ''
      fill_in 'Email', with: ''
      click_button 'Submit'
      expect(page).to have_content "All form fields cannot be empty"
    end

  end

  context "and change their email and username to a set already used by another user" do

    before do
      User.create(
        username: 'username1234',
        email: 'email1@test.com',
        password: 'password123',
        password_confirmation: 'password123'
        )
    end


    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Username', with: 'username1234'
      fill_in 'Email', with: 'email1@test.com'
      click_button 'Submit'
      expect(page).to have_content "Username has already been taken"
      expect(page).to have_content "Email has already been taken"
    end

  end

  context "and change their email and username to a those that do not fulfill length or format requirements" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Username', with: 'usern'
      fill_in 'Email', with: 'email2@test'
      click_button 'Submit'
      expect(page).to have_content "Username is too short (minimum is 7 characters)"
      expect(page).to have_content "Email has improper format"
    end

  end

  context "and change their password without the password confirmation field filled" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Password', with: 'username123'
      click_button 'Submit'
      expect(page).to have_content "Password confirmation can't be blank"
    end

  end

  context "and change their password with only the password confirmation field filled" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Password confirmation', with: 'password1234'
      click_button 'Submit'
      expect(page).to have_content "Password can't be blank"
    end

  end

  context "and change their password with incorrect password length and format" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Password', with: 'passw'
      fill_in 'Password confirmation', with: 'passw'
      click_button 'Submit'
      expect(page).to have_content "Password is too short (minimum is 8 characters); must contain 2 numbers"
    end

  end

  context "and correctly enters a new username, email, and password" do

    it "fails to have their edits persisted" do
      visit edit_user_path(user)
      fill_in 'Username', with: 'usernamenew123'
      fill_in 'Email', with: 'email@new.com'
      fill_in 'Password', with: 'passwordnew123'
      fill_in 'Password confirmation', with: 'passwordnew123'
      click_button 'Submit'
      expect(page).to have_content "User successfully edited"
    end

  end

end
