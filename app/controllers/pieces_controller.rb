class PiecesController < ApplicationController
  def show
    @game = selected_piece.game
  end

  def update
    row = piece_params[:x_position]
    column = piece_params[:y_position]

    if selected_piece.move_to!(row, column)
      selected_piece.game.swap_active_player(selected_piece.game.active_player)
    end
    redirect_to game_path(selected_piece.game)
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end

  def selected_piece
    @selected_piece ||= Piece.find(params[:id])
  end
end
