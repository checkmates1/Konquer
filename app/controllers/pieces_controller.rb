class PiecesController < ApplicationController
  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
  end

  def update
    @selected_piece = Piece.find(params[:id])
    @selected_piece.update_attributes(piece_params)
    # redirect_to game_path(@selected_piece.game)
  end

  private

  def piece_params
    params.permit(:x_position, :y_position)
  end
end
