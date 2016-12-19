class AddIndexToGameId < ActiveRecord::Migration
  def change
    remove_index :pieces, [:y_position, :x_position]
    add_index :pieces, [:game_id, :y_position, :x_position], unique: true
    add_index :pieces, :game_id
  end
end
