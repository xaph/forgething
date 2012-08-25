class AddStarredToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :starred, :boolean, :default => false
  end
end
