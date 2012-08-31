class AddDueDateToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :due_date, :datetime
  end
end
