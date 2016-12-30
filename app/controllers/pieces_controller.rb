class PiecesController < ApplicationController
  def show
    @selected_piece = Piece.find(params[:id])
    @game = @selected_piece.game
  end

  # def show
  #   @piece = Piece.find(piece_params)
  # not functional code just thinking through the process
  #   first_selected_piece = @piece
  #   first_selected_piece.update_attributes(x, y)
  # end
  # @piece.update_attributes.update_attributes(x, y)
  # end

  def update
    @selected_piece = Piece.find(params[:id])
    @selected_piece.update_attributes(piece_params)
    redirect_to game_path(@selected_piece)
    # redirect_to game_path
  end

  private

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
