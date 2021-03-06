class GamesController < ApplicationController
  def about; end

  def new
    @game = Game.new
  end

  def index
    @available_games = Game.available
  end

  def create
    @game = Game.create(game_params)
    @game.populate_board!

    redirect_to game_path(@game)
  end

  def show
    redirect_to root_path unless user_signed_in?
    @game = Game.find(params[:id])
    @white_player = User.find_by(id: @game.white_player_id) if @game.white_player_id
    @black_player = User.find_by(id: @game.black_player_id) if @game.black_player_id
  end

  def update
    @game = current_game
    @game.update_attributes(game_attributes)
    redirect_to game_path(@game)
  end

  def stalemate
    @game = current_game
    @game.destroy
    redirect_to game_path, alert: 'Stalemate. Game ends in a draw.'
  end

  def forfeit
    @game = current_game
    @game.forfeit(current_user)
    redirect_to game_path, alert: 'You have forfeited.'
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def game_attributes
    params.require(:game).permit(:white_player_id, :black_player_id)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
