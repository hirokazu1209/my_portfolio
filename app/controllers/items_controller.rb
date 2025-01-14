class ItemsController < ApplicationController
  def index
    # userに紐づくitemを取得。パラメータはプルダウンで対象月を選択する
    @items = current_user
  end
end
