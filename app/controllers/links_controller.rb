class LinksController < ApplicationController

  def new
    if !session[:user_id].present?
      redirect_to login_path, notice: 'You must be logged in to submit a link.'
    else
      @link = Link.new
    end
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = session[:user_id]

    if @link.save
      redirect_to root_path, notice: 'Link successfully submitted.'
    else
      render :new, notice: 'Error: Unable to submit link'
    end
  end

  def link_params
    params.require(:link).permit(
      :title,
      :url
    )
  end

end
