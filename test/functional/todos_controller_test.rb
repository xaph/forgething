require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user
    @todo = todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, todo: { description: @todo.description, name: 'newtodo', user_id: @todo.user_id }
    end

    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should show todo" do
    get :show, id: @todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todo
    assert_response :success
  end

  test "should update todo" do
    put :update, id: @todo, todo: { description: @todo.description, name: @todo.name, user_id: @todo.user_id }
    assert_redirected_to todos_path
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, id: @todo
    end

    assert_redirected_to todos_path
  end
end
