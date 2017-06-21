class HomeController < ApplicationController

  def index
    @links = Link.page(page).per(20)
  end

  def page
    @page ||= index_params[:page] || 1
  end
  helper_method(:page)

  def index_params
    params.permit(:page)
  end

end
