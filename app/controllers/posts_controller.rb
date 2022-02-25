class PostsController < ApplicationController
  def index
    @posts = Post.all
    @maps = Map.all
  end

  def new
    @post = Post.new
    @post.maps.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save!
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :video, :user_id)
  end


end
