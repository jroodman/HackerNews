class HomeController < ApplicationController

  def index
    case index_params[:sort]
    when 'new'
      @links = Link.order(created_at: :desc).page(page).per(20)
    else
      @links = Link.order(votes_count: :desc).page(page).per(20)
    end
    @sort_type ||= index_params[:sort] if index_params[:sort] == 'new'
  end

  private

  def page
    @page ||= index_params[:page] || 1
  end
  helper_method(:page)

  def index_params
    params.permit(:page, :sort)
  end

end
