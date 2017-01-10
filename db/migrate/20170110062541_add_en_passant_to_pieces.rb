class AddEnPassantToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :en_passant, :boolean, default: false
  end
end
