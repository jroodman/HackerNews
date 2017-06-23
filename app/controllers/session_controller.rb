class SessionController < ApplicationController

  def create
    parameters = session_params

    @user = User.find_by(username: parameters[:username]).try(:authenticate, parameters[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Successful login.'
    else
      redirect_to login_path, notice: 'Incorrect username or password.'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'You are now logged out.'
  end

  private

  def session_params
    params.require(:session).permit(
      :username,
      :password
    )
  end

end
