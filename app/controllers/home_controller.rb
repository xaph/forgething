class HomeController < ApplicationController
  def index
    if current_user
      redirect_to todos_url
    end
  end
end
