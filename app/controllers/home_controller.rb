class HomeController < ApplicationController
  def index
    if current_user
      redirect_to current_user
    else
      redirect_to "/shelter"
    end
  end
end
