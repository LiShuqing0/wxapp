class Mobile::FlowsController < Mobile::BaseController
	
  def index
    
  end

  def new
  	@flow = @user.flows.new
  end 
end