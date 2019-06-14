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
end