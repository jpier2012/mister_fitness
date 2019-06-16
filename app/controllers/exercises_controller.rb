class ExercisesController < ApplicationController

  get "/exercises" do
    redirect_if_not_logged_in
    @exercises = current_user.exercises
    erb :"exercises/index"
  end

  get "/exercises/new" do
    redirect_if_not_logged_in
    @workouts = current_user.workouts
    erb :"exercises/new"
  end

  post "/exercises" do
    if params[:clone_id]
      old_exercise = Exercise.find_by_id(params[:clone_id])
      exercise = old_exercise.dup
    else
      workout = current_user.workouts.find_by_id(params[:exercise][:workout_id])
      exercise = workout.exercises.build(params[:exercise])
      exercise.user = current_user
    end
    exercise.save
    session[:errors] = exercise.errors.to_a if exercise.errors.any?
    redirect "/workouts/#{ exercise.workout_id }"
  end

  get "/exercises/:id" do
    redirect_if_not_logged_in
    @exercise = current_user.exercises.find_by_id(params[:id])
    erb :"exercises/show"
  end

  get "/exercises/:id/edit" do
    redirect_if_not_logged_in
    @workouts = current_user.workouts
    @exercise = current_user.exercises.find_by_id(params[:id])
    redirect "/exercises" if !@exercise
    erb :"exercises/edit"
  end

  patch "/exercises/:id" do
    exercise = current_user.exercises.find_by_id(params[:id])
    exercise.update(params[:exercise])
    redirect "/exercises"
  end

  delete "/exercises/:id/delete" do
    exercise = current_user.exercises.find_by_id(params[:id])
    workout_id = exercise.workout_id
    exercise.delete if exercise
    redirect "/workouts/#{ workout_id }"
  end
end