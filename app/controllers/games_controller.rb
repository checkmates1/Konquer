class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create
    game.populate_board!

    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @white_player = User.find_by_id(@game.white_player_id) unless !@game.white_player_id
    @black_player = User.find_by_id(@game.black_player_id) unless !@game.black_player_id
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_attributes)
    redirect_to game_path(@game)
  end

  private

  def game_attributes
    params.require(:game).permit(:white_player_id, :black_player_id)
  end
end
