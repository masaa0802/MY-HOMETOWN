class CommentsController < ApplicationController

  def new
    @post= Post.find(params[:post_id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
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
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
