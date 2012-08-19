require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  test "should not save todo without name" do
    todo = Todo.new
    assert !todo.save, "Saved todo without name"
  end
end
