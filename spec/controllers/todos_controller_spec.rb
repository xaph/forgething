require "spec_helper"

describe TodosController do

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @todo = FactoryGirl.create(:todo, :user => @user)
    @todo2 = FactoryGirl.create(:todo, :name => "Pay Bills")
  end

  context "#index" do
     it "should get all his todos" do
       get :index
       assigns(:todos).should include(@todo)
       response.status.should be(200)
     end
     it "should not get someone elses todos" do
       get :index
       assigns(:todos).should_not include(@todo2)
       response.status.should be(200)
     end
  end

  context "#show" do
     it "should get his todo" do
       get :show, :id => @todo.id
       response.should render_template 'show'
       assigns(:todo).should eq(@todo)
       response.status.should be(200)
     end
    it "should not get someone elses todo" do
      get :show, :id => @todo2.id
      response.should_not render_template 'show'
      response.should redirect_to '/todos'
      response.status.should be(302)
    end
    it "should raise an error if todo doesnt exists " do
      get :show, :id => 78741399
      flash[:error].should == 'The todo you tried to access does not exist'
      response.should redirect_to '/todos'
    end
  end

  context "#all" do
      it "should show all todos" do
        @todo3 = FactoryGirl.create(:todo, :name => "Get a job", :user => @user)
        delete :complete, :id => @todo3.id
        get :all
        assigns(:todos).should include(@todo)
        assigns(:todos).should include(@todo3)
        response.status.should be(200)
      end
      it "should not show someone elses todos" do
        get :all
        assigns(:todos).should_not include(@todo2)
        response.status.should be(200)
      end
  end

  context "#new" do
     it "should get new todo page" do
       get :new
       response.should render_template 'new'
       response.status.should be(200)
     end
  end

  context "#edit" do
      it "should get edit page for his todo" do
        get :edit, :id => @todo.id
        response.should render_template 'edit'
        response.status.should be(200)
      end
      it "should not get edit page for someone elses todo" do
        get :edit, :id => @todo2.id
        response.should_not render_template 'edit'
        response.should redirect_to '/todos'
        response.status.should be(302)
      end
  end

  context "#update" do
      it "should update his todo" do
        put :update, :todo => {:name => "Updated Todo", :description => "Updated Description", :due_date => "2014-09-11 05:26", :tag_ids => [""]}, :id => @todo.id
        t = Todo.find(@todo)
        t.name.should == "Updated Todo"
        response.should redirect_to '/todos'
        response.status.should be(302)
      end
      it "should not update his todo with invalid params" do
        put :update, :todo => {:name => "", :description => "Updated Description", :due_date => "2014-09-11 05:26", :tag_ids => [""]}, :id => @todo.id
        t = Todo.find(@todo)
        t.description.should_not == "Updated Description"
        response.status.should be(200)
      end
      it "should not update someone elses todo" do
        put :update, :todo => {:name => "Updated Todo", :description => "Updated Description", :due_date => "2014-09-11 05:26", :tag_ids => [""]}, :id => @todo2.id
        t = Todo.find(@todo2)
        t.name.should_not == "Updated Todo"
        response.should redirect_to '/todos'
        response.status.should be(302)
      end
  end

  context "#create" do
      it "should create a new todo" do
        post :create, :todo => {:name => "merhaba"}
        Todo.last.name.should == "merhaba"
        flash[:notice].should == "Todo was successfully created."
        response.status.should be(302)
      end
      it "should not create a new todo with invalid params" do
        post :create, :todo => {:name => ""}
        Todo.last.name.should_not == ""
        flash[:notice].should be_nil
        response.status.should be(200)
      end
  end

  context "#destroy" do
    it "should delete his todo" do
      delete :destroy, :id => @todo.id
      t = Todo.unscoped.find(@todo)
      t.deleted_at.should_not be_nil
      response.should redirect_to '/todos'
      response.status.should be(302)
    end
    it "should not delete someone elses todo" do
      delete :destroy, :id => @todo2.id
      t = Todo.unscoped.find(@todo2)
      t.deleted_at.should be_nil
      response.should redirect_to '/todos'
      response.status.should be(302)
    end
  end

  context "#complete" do
      it "should complete his todo" do
        delete :complete, :id => @todo.id
        t = Todo.find(@todo)
        t.completed_at.should_not be_nil
        response.should redirect_to '/todos'
        response.status.should be(302)
      end
      it "should not complete someone elses todo" do
        delete :complete, :id => @todo2.id
        t = Todo.find(@todo2)
        t.completed_at.should be_nil
        response.should redirect_to '/todos'
        response.status.should be(302)
      end
  end

  context "#star" do
      it "should star his todo" do
        get :star , :id => @todo.id
        t = Todo.find(@todo)
        t.starred.should be_true
      end
      it "should not star someone elses todo" do
        get :star , :id => @todo2.id
        t = Todo.find(@todo2)
        t.starred.should be_false
      end
  end

  context "#unstar" do
    it "should unstar his todo" do
      get :star , :id => @todo.id
      get :unstar , :id => @todo.id
      t = Todo.find(@todo)
      t.starred.should be_false
    end
  end
end