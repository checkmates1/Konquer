class PiecesController < ApplicationController
  def show
    @game =  Game.find(params[:id])
    @piece = Piece.find(params[:id])

  end

  #   @piece.selected_updated_atrributes(x_position: x, y_position: y)
  # end
  # def update
  #   @piece = Piece.find(params:id)


  private

  def piece_params
    params.require(:piece).permit(:show,:x_position, :y_position)
  end

end
