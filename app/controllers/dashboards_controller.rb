class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @games = Game.all
    @user_games = current_user.games
  end

end
