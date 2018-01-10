class Mobile::BaseController < ActionController::Base
  layout "mobile"

  # 用户登录后24小时内不做任何操作将自动退出
  # MAX_SESSION_TIME = 60 * 60 * 24

  # ADMIN_FILTERS = [:required_sign_in]
  before_filter :set_current_user
  # before_filter :prepare_session, :set_current_user
  # before_filter *ADMIN_FILTERS
  # helper_method :current_user

  # private

  def set_current_user
  	@user = User.first
  end

  # def prepare_session
  #   if session[:expiry_time].present? and session[:expiry_time] < Time.now
  #     reset_session
  #   end
  #   session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now
  #   return true
  # end

  # def set_current_user
  #   User.current = current_user
  # end

  # def required_sign_in
  #   unless current_user
  #     flash[:alert] = "你还没有登录，请先登录..."
  #     store_location
  #     redirect_to wap_sign_in_path
  #   end
  # end

  # def current_user(force_reload = false)
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #   @current_user.reload if force_reload
  #   @current_user
  # end

  # def store_location
  #   session[:return_to] = request.path
  # end

  # def clear_sign_in_session
  #   session[:user_id] = nil
  # end

end
