class AuthenticationsController < ApplicationController
  def index
  	@authentications = current_user.authentications if current_user
  end
  
  def create
	omniauth = request.env["omniauth.auth"]
    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      # Authentication found, sign the user in.
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.build_with_provider(omniauth)
      redirect_to authentications_url
    else
      # Authentication not found, thus a new user.
      user = User.new
      user.build_with_provider(omniauth)
      user.save!(:validate => false)
      sign_in_and_redirect(:user, user)
    end
  end
  
  def destroy
  	@authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
