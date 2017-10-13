class Back::SessionsController < Back::BaseController
  skip_before_filter *ADMIN_FILTERS

  def new
  end

  def create
    clear_sign_in_session

    if account = Account.authenticated(params[:mobile], params[:password])
      session[:user_id] = user.id
      return render json: {code: 0, url: , message: "登录成功!", status: 1}
    else
      return render json: {code: -2, message: "帐号或密码错误", status: 0}
    end
  rescue => error
    return render json: {code: -3, message: '登录失败', status: 0}
  end

  def destroy
    clear_sign_in_session

    redirect_to ''
  end
end