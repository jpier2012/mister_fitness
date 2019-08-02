class SessionsController < ApplicationController


  get "/login" do
    error_check
    erb :"sessions/login"
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/workouts"
    elsif user
      session[:errors] = ["Please enter a valid password"]
      redirect "/login"
    else
      session[:errors] = ["Please enter a valid username"]
      redirect "/login"
    end
  end

  get "/logout" do
    session.destroy
    redirect "/login"
  end
end