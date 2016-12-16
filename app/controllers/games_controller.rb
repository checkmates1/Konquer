class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create
  end

  def show
    @game = Game.last
  end
end
