class HomesController < ApplicationController
  before_action :authenticate_user!

  def top
    @user = current_user
  end
end
