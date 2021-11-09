class PostsController < ApplicationController
  def index
     @post= Post.find(params[:id])
  end

  def show
     @post= Post.find(params[:id])
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.create
    redirect_to @post
  end

  def destroy
  end
  
  def post_params
    params.require(:post).permit(:caption, :video)
  end
end
