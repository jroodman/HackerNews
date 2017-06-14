class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'User successfully created.'
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end

end