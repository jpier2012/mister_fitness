class WorkoutsController < ApplicationController
  get "/workouts" do
    redirect_if_not_logged_in
    @workouts = current_user.workouts.order(created_at: :desc)
    erb :"workouts/index"
  end

  get "/workouts/new" do
    redirect_if_not_logged_in
    erb :"workouts/new"
  end

  post "/workouts" do
    if params[:clone_id]
      old_workout = Workout.find_by_id(params[:clone_id])
      workout = old_workout.dup
      workout.save
      old_workout.exercises.each do |e|
        new_exercise = e.dup
        new_exercise.workout_id = workout.id
        new_exercise.save
      end
    else
      workout = current_user.workouts.create(params[:workout])
      exercise = workout.exercises.build(params[:exercise])
      exercise.user = current_user
      exercise.save
      session[:errors] = exercise.errors.to_a if exercise.errors.any?
    end
    redirect "/workouts/#{ workout.id }"
  end

  get "/workouts/community" do
    redirect_if_not_logged_in
    @workouts = Workout.all
    erb :"workouts/community"
  end

  get "/workouts/:id" do
    redirect_if_not_logged_in
    error_check
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
    workout.update(params[:workout])
    session[:errors] = workout.errors.to_a if workout.errors.any?
    redirect "/workouts/#{workout.id}"
  end

  delete "/workouts/:id/delete" do
    workout = current_user.workouts.find_by_id(params[:id])
    workout.delete if workout
    redirect "/workouts"
  end
end