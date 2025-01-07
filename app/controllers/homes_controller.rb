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
    if @user.update!(user_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@user, partial: "homes/user", locals: { user: @user }) }
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@user, partial: "homes/user", locals: { user: @user }) }
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_picture_pass)
  end
end
