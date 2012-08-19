require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  test "should not save todo without name" do
    todo = Todo.new
    assert !todo.save
  end
end
