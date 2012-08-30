class CreateTagsTodos < ActiveRecord::Migration
  def up
    create_table :tags_todos, :id => false do |t|
      t.references :tag
      t.references :todo
    end
    add_index :tags_todos, [:tag_id, :todo_id]
    add_index :tags_todos, [:todo_id, :tag_id]
  end

  def down
    drop_table :tags_todos
  end
end
