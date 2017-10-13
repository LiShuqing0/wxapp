class Back::AccountsController < Back::BaseController
	
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

    def find_account
      @account = Account.find(params[:id].to_i) rescue nil
      return redirect_to :back || back_accounts_path, alert: "账号信息不存在 请查证后再试" unless @account
    end  
end