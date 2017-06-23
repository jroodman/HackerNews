require 'rails_helper'

RSpec.describe "a client viewing the home page", type: :feature do

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

  let!(:link2) do
    Link.create(
      title: 'Test Link2',
      url: 'http://www.testlink2.com/',
      user: user
    )
  end

  context "with links present in database" do

    it "should see links visible on the page" do
      visit root_path
      expect(page).to have_content 'Test Link1'
      expect(page).to have_content 'Test Link2'
    end

  end

end
