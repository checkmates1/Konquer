class PiecesController < ApplicationController
  
  def show
    @pieces = current_game.pieces.order(:y_position).order(:x_position).to_a
  end

  # def show
  #   @piece = Piece.find(piece_params)
#not functional code just thinking through the process
    #   first_selected_piece = @piece
    #   first_selected_piece.update_attributes(x, y)
    # end
    # @piece.update_attributes.update_attributes(x, y)
  # end

  def update
    redirect_to game_path
  end

  private
  
  def current_game
    @game ||= selected_piece.game
  end

  def selected_piece
    @selected_piece ||= Piece.find(params[:id])
  end

end
