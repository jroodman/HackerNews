class HomeController < ApplicationController

  def index
    order_condition = index_params[:sort] == 'new' ? { created_at: :desc } : { votes_count: :desc }
    @links = Link.order(order_condition).page(page).per(20)
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
