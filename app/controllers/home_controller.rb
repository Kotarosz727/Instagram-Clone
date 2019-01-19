class HomeController < ApplicationController

  def upload
    @micropost  = current_user.microposts.build
  end  
end
