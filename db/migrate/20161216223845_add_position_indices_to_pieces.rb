class AddPositionIndicesToPieces < ActiveRecord::Migration
  def change
    add_index :pieces, [:y_position, :x_position], unique: true
  end
end
