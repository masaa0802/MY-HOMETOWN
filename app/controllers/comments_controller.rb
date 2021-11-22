class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy create]

  def new
    @comment = current_user.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
  end
  
  def update
    @comment.update!(comment_update_params)
    render json: @comment
  end

  def destroy
    @comment.destroy!
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
