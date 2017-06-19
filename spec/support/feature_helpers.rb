module FeatureHelpers

  def login_user(username, password)
    visit login_path
    fill_in 'Username', with: username.to_s
    fill_in 'Password', with: password.to_s
    click_button 'Login'
  end

end
