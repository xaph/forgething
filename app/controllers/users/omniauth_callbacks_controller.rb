class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def omniauth_create(omniauth)
    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication.present?
      # Authentication found, sign the user in.
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.build_with_provider(omniauth)
      redirect_to authentications_url
    else
      # Authentication not found, thus a new user.
      user = User.find_by_email(omniauth['info']['email']) || User.new
      user.build_with_provider(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else #twitter user
        session[:omniauth] = omniauth.except('extra')
        flash[:notice] = "One more step left. Please enter your email"
        redirect_to new_user_registration_url
      end
    end
  end

  def facebook
  	omniauth_create(request.env["omniauth.auth"])
  end

  def twitter
  	omniauth_create(request.env["omniauth.auth"])
  end

  def google
  	omniauth_create(request.env["omniauth.auth"])
  end

end