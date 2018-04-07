class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login_required
    redirect_to login_path unless logged_in
  end

  def logged_in
    !!current_bander
  end

  def current_bander
    @current_bander ||= Bander.find_by_slug(session[:bander_id]) if session[:bander_id]
  end
  helper_method :current_bander

end
