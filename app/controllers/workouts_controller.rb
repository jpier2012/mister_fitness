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

  get "/workouts/community" do
    redirect_if_not_logged_in
    @workouts = Workout.all
    erb :"workouts/community"
  end

  get "/workouts/:id" do
    redirect_if_not_logged_in
    @workout = current_user.workouts.find_by_id(params[:id])
    redirect "/workouts" if !@workout
    erb :"workouts/show"
  end

  get "/workouts/:id/edit" do
    redirect_if_not_logged_in
    @workout = current_user.workouts.find_by_id(params[:id])
    redirect "/workouts" if !@workout
    erb :"workouts/edit"
  end

  patch "/workouts/:id" do
    workout = current_user.workouts.find_by_id(params[:id])
    workout.update(name: params[:name], description: params[:description], instructions: params[:instructions])
    redirect "/workouts/#{workout.id}"
  end

  delete "/workouts/:id/delete" do
    workout = current_user.workouts.find_by_id(params[:id])
    workout.delete if workout
    redirect "/workouts"
  end
end