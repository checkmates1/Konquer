class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @games = Game.all
  end

end
