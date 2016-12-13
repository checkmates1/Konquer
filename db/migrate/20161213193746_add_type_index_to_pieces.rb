class AddTypeIndexToPieces < ActiveRecord::Migration
  def change
    add_index :pieces, :type
  end
end
