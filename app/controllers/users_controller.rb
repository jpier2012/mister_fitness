class UsersController < ApplicationController
  get "/signup" do
    redirect "/workouts" if logged_in?
    @errors = session[:errors] if !session[:errors].empty?
    erb :"users/signup"
  end

  post "/signup" do
    user = User.create(params)
    if user.persisted?
      session[:user_id] = user.id
      redirect "/workouts"
    else
      session[:errors] = user.errors.to_a
      redirect "/signup"
    end
  end
end