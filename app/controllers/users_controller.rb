class UsersController < ApplicationController
  get "/signup" do
    redirect "/workouts" if logged_in?
    erb :"users/signup"
  end

  post "/signup" do
    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect "/workouts"
  end

  get "/login" do
    erb :"users/login"
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/workouts"post
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end
end