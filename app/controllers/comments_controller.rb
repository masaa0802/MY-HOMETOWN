class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  
  def update
    @comment.update!(comment_update_params)
    render json: @comment
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
