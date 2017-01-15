class PiecesController < ApplicationController
  def show
    @game = selected_piece.game
  end

  def update
    selected_piece.update_attributes(piece_params)
    redirect_to game_path(selected_piece.game)
  end

  private

  def piece_params
    params.permit(:x_position, :y_position)
  end

  def selected_piece
    @selected_piece ||= Piece.find(params[:id])
  end
end
