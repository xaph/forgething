class AddDeletedAtToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :deleted_at, :datetime, :default => nil
  end
end
