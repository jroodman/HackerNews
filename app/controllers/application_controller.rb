class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= session[:user_id].present? ? User.find(session[:user_id]) : nil
  end
  helper_method(:current_user)

end
