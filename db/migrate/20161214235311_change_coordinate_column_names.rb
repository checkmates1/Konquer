class ChangeCoordinateColumnNames < ActiveRecord::Migration
  def change
    rename_column :pieces, :column, :x_position
    rename_column :pieces, :row, :y_position
  end
end
