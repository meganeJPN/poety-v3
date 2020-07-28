class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update,:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to poeets_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    binding.pry
    unless @user.id == current_user.id then
      redirect_to poeets_path,notice:"他のユーザのプロフィールは編集できません。"
      return "other user profike"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice:"プロフィールを更新しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:image, :image_cache)
  end
  def user_update_params
    params.require(:user).permit(:name,:email, :image, :image_cache)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
