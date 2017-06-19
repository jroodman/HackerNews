require 'rails_helper'

RSpec.describe "a client attempting to login to their acccount", type: :feature do

  let!(:user) do
    User.create(
      username: 'username123',
      email: 'email@test.com',
      password: 'password123',
      password_confirmation: 'password123'
      )
  end

  context "with an empty username field" do

    it "is unable to successfully login" do
      visit login_path
      fill_in 'Password', with: 'password123'
      click_button 'Login'
      expect(page).to have_content "Incorrect username or password"
    end

  end

  context "with an empty password field" do

    it "is unable to successfully login" do
      visit login_path
      fill_in 'Username', with: 'username123'
      click_button 'Login'
      expect(page).to have_content "Incorrect username or password"
    end

  end

  context "with an incorrect username and password" do

    it "is unable to successfully login" do
      visit login_path
      fill_in 'Username', with: 'username1234'
      fill_in 'Password', with: 'password1234'
      click_button 'Login'
      expect(page).to have_content "Incorrect username or password"
    end

  end

  context "with a correct username and password" do

    it "is able to successfully login" do
      visit login_path
      fill_in 'Username', with: 'username123'
      fill_in 'Password', with: 'password123'
      click_button 'Login'
      expect(page).to have_content "Successful login"
    end

  end

end
