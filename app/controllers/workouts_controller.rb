class WorkoutsController < ApplicationController
  get "/workouts" do
    redirect_if_not_logged_in
    @workouts = current_user.workouts
    erb :"workouts/index"
  end

  get "/workouts/new" do
    redirect_if_not_logged_in
    erb :"workouts/new"
  end

  post "/workouts" do
    workout = current_user.workouts.create(name: params[:name], description: params[:description], instructions: params[:instructions])
    redirect "/workouts"
  end

  get "/workouts/:id" do
    redirect_if_not_logged_in
    @workout = current_user.workouts.find_by_id(params[:id])
    # show details for specific workout
    erb :"workouts/show"
  end

  get "/workouts/:id/edit" do
    redirect_if_not_logged_in
    @workout = current_user.workouts.find_by_id(params[:id])
    erb :"workouts/edit"
  end

  patch "/workouts/:id" do
    # uses params[:id] to update attributes for a workout
  end
end