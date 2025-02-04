class ItemsController < ApplicationController
  before_action :set_category, only: %i[new create]

  def index
    today = Date.today
    current_year = today.year
    @month_options = (0..2).map { |i| (today - i.months).strftime('%Y%m').to_i }
    target_month = (params[:target_month] || today.strftime('%m')).to_i
    @selected_month = "#{current_year}#{format('%02d', target_month)}".to_i
    @items_grouped_by_category = Item.by_target_month(@selected_month).includes(:user, :category).order(:id).group_by(&:category)
    @categories = Category.all

    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace('items-list', partial: 'items/list', locals: { items: @items_grouped_by_category, categories: @categories }) }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user: current_user, category: @category))
    if @item.save
      @modal_message = "#{@category.name}の学習内容を登録しました！"
      respond_to do |format|
        format.html { redirect_to items_path, notice: @modal_message }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", partial: "items/create_modal")
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    @category = @item.category
    if @item.update(item_params)
      @modal_message = "#{@item.name}の学習内容を更新しました！"
      respond_to do |format|
        format.html { redirect_to items_path, notice: @modal_message }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", partial: "items/create_modal")
        end
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      @modal_message = "#{@item.name}を削除しました！"
      respond_to do |format|
        format.html { redirect_to items_path, notice: @modal_message }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("modal", partial: "items/create_modal")
        end
      end
    else
      render :index, status: :unprocessable_entity
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
