class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login_required
    redirect_to login_path unless !!session[:bander_id]
  end

end
