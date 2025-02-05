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
    if @user.update_without_password(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def graph
    @user = current_user

    today = Date.today
    @month_options = (0..2).map {|i| (today - i.month).strftime('%Y%m').to_i}
    @study_data = Item.where(user: @user)
                      .where("TO_CHAR(updated_at, 'YYYYMM') IN (?)", @month_options.map(&:to_s))
                      .group_by { |item| [item.updated_at.strftime('%Y%m'), item.category.name] }
                      .transform_values(&:count)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :self_introduction, :profile_picture_pass)
  end
end
