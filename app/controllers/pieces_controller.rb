class PiecesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @piece = Piece.find(params[:id])
    # redirect_to :back
  end
end
