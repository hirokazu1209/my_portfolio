class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :create]

  def index
    @month_options = Item.new.generate_month_options
    @selected_month = (params[:target_month] || Date.today.strftime('%Y%m')).to_i
    @items_grouped_by_category = Item.by_target_month(@selected_month).includes(:user, :category).group_by(&:category)

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace('items-list', partial: 'items/list', locals: { items: @items_grouped_by_category }) }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user: current_user, category: @category))
    if @item.save
      respond_to do |format|
        format.html { redirect_to items_path, notice: "学習内容を登録しました" }
        format.turbo_stream
      end
    else
      Rails.logger.debug(@item.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def item_params
    params.require(:item).permit(:name, :study_time)
  end
end
