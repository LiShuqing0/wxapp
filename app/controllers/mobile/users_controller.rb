class Mobile::UsersController < Mobile::BaseController
	
  def index
    @user = User.first
  end 
end