class UsersController < ApplicationController
  get "/signup" do
    redirect "/workouts" if logged_in?
    erb :"users/signup"
  end

  post "/signup" do
    user = User.create(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.persisted?
      session[:user_id] = user.id
      redirect "/workouts"
    else
      redirect "/signup"
    end
  end
end