class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :type
      t.integer :column
      t.integer :row

      t.timestamps
    end
  end
end
