class AddWinnerIdColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :winning_player_id, :integer
    add_index :games, :winning_player_id
  end
end
