class CommentsController < ApplicationController

  def index
    @link = Link.find(params[:link_id])
    @comments = @link.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    if current_user.comment.create(new_comment_params)
      redirect_to root_path, notice: 'Comment successfully created.'
    else
      flash[:error] = "Error: Unable to create comment"
      render :new
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])

    if comment.present? && !comment.children.exists?
      comment.try(:destroy)
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def index_comment_params
    params.require(:link_id)
  end

  def new_comment_params
    params.require(:comment).allow(:text, :user_id, :link_id, :parent_comment_id)
  end

end
