class PiecesController < ApplicationController
  def show
    @game =  Game.find(params[:id])
    @piece = Piece.find(params[:id])
#not functional code just thinking through the process
      first_selected_piece = @piece
      first_selected_piece.update_attributes(x, y)
    end
    @piece.update_attributes.update_attributes(x, y)
  end

  def update
    @piece = Piece.find(params:id)
    x = params[:x_position]
    y = params[:y_position]
    




  private

  def piece_params
    params.require(:piece).permit(:show, :x_position, :y_position)
  end

end
