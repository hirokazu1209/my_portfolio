class ItemsController < ApplicationController
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
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :study_time, :category_id)
  end
end
