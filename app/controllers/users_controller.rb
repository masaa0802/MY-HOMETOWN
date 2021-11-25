class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user= User.new(user_params)
    @user.save
    redirect_to @user
  end
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:image)
  end

end
