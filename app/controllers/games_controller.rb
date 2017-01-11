class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.populate_board!

    redirect_to game_path(@game)
  end

  def show
    redirect_to root_path unless user_signed_in?
    @game = Game.find(params[:id])
    @selected_piece = Piece.find(params[:id])
    @white_player = User.find_by(id: @game.white_player_id) if @game.white_player_id
    @black_player = User.find_by(id: @game.black_player_id) if @game.black_player_id
  end

  def update
    @game = current_game
    @game.update_attributes(game_attributes)
    @selected_piece = Piece.find(params[:id])
    @selected_piece.update_attributes(piece_position)
  end

  def forfeit
    @game = current_game
    @game.forfeit(current_user)
    redirect_to game_path, alert: 'You have forfeited.'
  end

  private

  def piece_position
    params.permit(:x_position, :y_position)
  end

  def game_params
    params.require(:game).permit(:name)
  end

  def game_attributes
    params.permit(:white_player_id, :black_player_id, :x_position, :y_position)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
