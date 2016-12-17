class AddDefaultToPieceStatus < ActiveRecord::Migration
  def change
    change_column :pieces, :status, :integer, :default => 1
  end
end
