class HomesController < ApplicationController
  before_action :authenticate_user!

  def top
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "編集が完了しました"
      redirect_to root_path
    else
      flash[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_picture_pass)
  end
end
