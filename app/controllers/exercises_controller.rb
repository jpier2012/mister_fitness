class ExercisesController < ApplicationController

  get "/exercises" do
    redirect_if_not_logged_in
    @exercises = current_user.exercises
    erb :"exercises/index"
  end

  get "/exercises/new" do
    redirect_if_not_logged_in
    error_check
    @workouts = current_user.workouts
    erb :"exercises/new"
  end

  # the clone feature was not required for the project but was added for a fun challenge,
  # it allows you to duplicate a workout created by another user 

  post "/exercises" do
    if params[:clone_id]
      old_exercise = Exercise.find_by_id(params[:clone_id])
      exercise = old_exercise.dup
      exercise.workout_id = params[:exercise][:workout_id]
      exercise.save
    elsif params[:exercise][:workout_id] != ""
      workout = current_user.workouts.find_by_id(params[:exercise][:workout_id])
      exercise = workout.exercises.create(params[:exercise])
    else
      session[:errors] = ["Please select a workout from the dropdown"]
      redirect "/exercises/new"
    end
    log_errors(exercise)
    redirect "/workouts/#{ exercise.workout_id }/edit"
  end

  get "/exercises/:id" do
    redirect_if_not_logged_in
    @exercise = current_user.exercises.find_by_id(params[:id])
    redirect "/exercises" if !@exercise
    erb :"exercises/show"
  end

  get "/exercises/:id/edit" do
    redirect_if_not_logged_in
    error_check
    @workouts = current_user.workouts
    @exercise = current_user.exercises.find_by_id(params[:id])
    redirect "/exercises" if !@exercise
    erb :"exercises/edit"
  end

  patch "/exercises/:id" do
    exercise = Exercise.find_by_id(params[:id])
    redirect "/workouts" if !authorized_to_edit?(exercise.workout)
    if params[:exercise][:workout_id] == ""
      session[:errors] = ["Please select a workout from the dropdown"]
      redirect "/exercises/#{ exercise.id }/edit"
    end
    exercise.update(params[:exercise])
    redirect "/workouts/#{ exercise.workout_id }/edit"
  end

  delete "/exercises/:id/delete" do
    exercise = Exercise.find_by_id(params[:id])
    redirect "/workouts" if !authorized_to_edit?(exercise.workout)
    workout_id = exercise.workout_id
    exercise.delete if exercise
    redirect "/workouts/#{ workout_id }/edit"
  end
end