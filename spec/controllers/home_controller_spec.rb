require "spec_helper"

describe HomeController do

  before do
    @user = FactoryGirl.create(:user)
  end

  context "#index" do

    it "should redirect to todos_url" do
      sign_in @user
      get :index
      response.should redirect_to todos_url
    end
    it "should not redirect to todos_url if user not logged in" do
      get :index
      response.should_not redirect_to todos_url
    end

  end

end