class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wins, :integer
    add_column :users, :losses, :integer
    add_column :users, :username, :string
  end
end
