# ForgeThing - Simple todo app
# Copyright (C) 2012  Zafer Cakmak
# 
# This file is part of ForgeThing.
# 
# ForgeThing is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# ForgeThing is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with ForgeThing.  If not, see <http://www.gnu.org/licenses/>.

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
