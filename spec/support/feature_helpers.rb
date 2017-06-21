module FeatureHelpers

  def login_user(user = nil)
    user ||= User.create(username: 'username123', password: 'password123')

    visit login_path

    fill_in 'Username', with: user.username.to_s
    fill_in 'Password', with: user.password.to_s

    click_button 'Login'
  end

end
