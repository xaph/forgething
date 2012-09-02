require 'spec_helper'

describe AuthenticationsController do
  before do
    @user = FactoryGirl.create(:user)
    @authentication = FactoryGirl.create(:authentication, :user => @user)
  end

  context "#create" do
    before do
      @omniauth = {
          'uid' => "12345",
          'provider' => "facebook"
      }
      request.env["omniauth.auth"] = @omniauth
    end

    context "user logged in" do
        it "should not create authentication " do
          sign_in @user
          @user.authentications.create!(:provider => "facebook", :uid => "12345")
          post :create
          @user.reload.should have(1).authentication
        end
        it "should create a new authentication for this user" do
          sign_in @user
          expect{post :create, :provider => "facebook"}.to change{Authentication.count}.by(1)
        end
        it "should create new authentication and user" do
          expect{post :create, :provider => "facebook"}.to change{Authentication.count}.by(1)
        end

    end

    context "user logged out" do
      context "user has attached authentication", "and logging in" do
        before { @user.authentications.create!(:provider => "facebook", :uid => "12345") }
        it "should sign in user" do
          post :create
          controller.send(:current_user).should == @user
        end

        it "should redirect" do
          post :create
          response.should be_redirect
        end
      end
    end

  end

  context "#index" do
    it "should get user's authentications" do
      sign_in @user
      get :index
      assigns(:authentications).should include(@authentication)
    end
  end

  context "#destroy" do
    it "should delete his authentication" do
      sign_in @user
      delete :destroy, :id => @authentication.id
      flash[:notice].should == "Successfully destroyed authentication."
      response.should redirect_to authentications_url
    end
  end
end