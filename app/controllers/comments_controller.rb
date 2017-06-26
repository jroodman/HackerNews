class CommentsController < ApplicationController

  def index
    @link = Link.find(index_param)
    @new_comment = Comment.new
    @comments = @link.comments
  end

  def new
    @comment = Comment.find(new_comment_param)
    @new_comment = Comment.new
  end

  def create_link_comment
    comment = current_user.comments.create(create_comment_params.merge(link_id: params[:id]))
    if comment.persisted?
      redirect_to root_path, notice: 'Comment successfully created.'
    else
      flash[:error] = "Error: Unable to create comment"
      redirect_back(fallback_location: root_path)
    end
  end

  def create_child
    comment = current_user.comments.create(create_comment_params.merge(parent_comment_id: params[:id]))
    if comment.persisted?
      redirect_to root_path, notice: 'Comment successfully created.'
    else
      flash[:error] = "Error: Unable to create comment"
      redirect_back(fallback_location: root_path)
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

  def index_param
    params.require(:link_id)
  end

  def new_comment_param
    params.require(:comment_id)
  end

  def create_comment_params
    params.require(:comment).permit(:text)
  end

end
