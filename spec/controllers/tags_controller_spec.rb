require "spec_helper"

describe TagsController do

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @todo = FactoryGirl.create(:todo, :user => @user)
    @todo2 = FactoryGirl.create(:todo, :name => "Pay Bills")
    @tag = FactoryGirl.create(:tag, :user => @user)
    @tag2 = FactoryGirl.create(:tag)
  end

  context "#index" do
    it "should get all his tags" do
      get :index
      assigns(:tags).should include(@tag)
      response.status.should be(200)
    end
    it "should not get someone elses tags" do
      get :index
      assigns(:tags).should_not include(@tag2)
      response.status.should be(200)
    end
  end

  context "#show" do
    it "should get his tag" do
      get :show, :id => @tag.id
      response.should render_template 'todos/index'
      assigns(:tag).should eq(@tag)
      response.status.should be(200)
    end
    it "should not get someone elses tag" do
      get :show, :id => @tag2.id
      response.should_not render_template 'todos/index'
      response.status.should be(302)
    end
    it "should raise an error if tag doesnt exists " do
      get :show, :id => 78741399
      flash[:error].should == 'The tag you tried to access does not exist'
      response.should redirect_to '/todos'
    end
  end

  context "#new" do
    it "should get new tag page" do
      get :new
      response.should render_template 'new'
      response.status.should be(200)
    end
  end

  context "#edit" do
    it "should get edit page for his tag" do
      get :edit, :id => @tag.id
      response.should render_template 'edit'
      response.status.should be(200)
    end
    it "should not get edit page for someone elses tag" do
      get :edit, :id => @tag2.id
      response.should_not render_template 'edit'
      response.status.should be(302)
    end
  end

  context "#update" do
    it "should update his tag" do
      put :update, :tag => {:name => "Updated Tag"}, :id => @tag.id
      t = Tag.find(@tag)
      t.name.should == "Updated Tag"
      response.status.should be(302)
    end
    it "should not update his tag with invalid params" do
      put :update, :tag => {:name => ""}, :id => @tag.id
      t = Tag.find(@tag)
      t.name.should_not == ""
      response.status.should be(200)
    end
    it "should not update someone elses tag" do
      put :update, :tag => {:name => "Updated Tag"}, :id => @tag2.id
      t = Tag.find(@tag2)
      t.name.should_not == "Updated Tag"
      response.should redirect_to '/todos'
      response.status.should be(302)
    end
  end

  context "#create" do
    it "should create a new tag" do
      post :create, :tag => {:name => "MyTag"}
      Tag.last.name.should == "MyTag"
      flash[:notice].should == "Tag was successfully created."
      response.status.should be(302)
    end
    it "should not create a new tag with invalid params" do
      post :create, :tag => {:name => ""}
      Tag.last.name.should_not == ""
      flash[:notice].should be_nil
      response.status.should be(200)
    end
  end

  context "#destroy" do
    it "should delete his tag" do
      expect{delete :destroy, :id => @tag.id}.to change{Tag.count}.by(-1)
    end
    it "should not delete someone elses tag" do
      expect{delete :destroy, :id => @tag2.id}.to change{Tag.count}.by(0)
    end
  end

end