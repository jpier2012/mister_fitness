class WorkoutsController < ApplicationController
  get "/workouts" do
    redirect_if_not_logged_in
    #select all workouts for the current user and display them in a list format
    "Hello world"
  end

  get "/workouts/new" do
    redirect_if_not_logged_in
    # erb :"workouts/new"
  end

  post "/workouts" do
    # create new workout for current user
  end

  get "/workouts/:id" do
    redirect_if_not_logged_in
    # show details for specific workout
    # erb :"workouts/show"
  end

  get "/workouts/:id/edit"
    redirect_if_not_logged_in
    # erb :"workouts/edit"
  end

  patch "/workouts/:id" do
    # uses params[:id] to 
  end

  

end