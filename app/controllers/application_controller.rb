require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "jimmers"
  end

  get "/" do
    redirect "/login"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id])
    end

    def redirect_if_not_logged_in
      redirect "/login" if !logged_in?
    end

    def error_check
      @errors = session.delete(:errors)
    end

    def log_errors(obj)
      session[:errors] = obj.errors.to_a if obj.errors.any?
    end

    def authorized_to_edit?(object)
      object.user_id == current_user.id
    end
  end

end
