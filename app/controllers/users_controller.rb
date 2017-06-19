class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'User successfully created.'
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def update
    # @user = User.find(session[:user_id])
    @user = User.find(params[:id])

    parameters = remove_empty user_params

    if parameters.any? && @user.update_attributes(parameters)
      redirect_to root_path, notice: 'User successfully edited.'
    else
      @form_empty = "All form fields cannot be empty." if parameters.empty?
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end

  def remove_empty(parameters)
    parameters.to_h.reduce(Hash.new) do |hash, (k, v)|
      v.present? ? hash.merge(k => v) : hash
    end
  end

end
