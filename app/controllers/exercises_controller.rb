class ExercisesController < ApplicationController

  get "/exercises" do
    @exercises = current_user.exercises
    erb :"exercises/index"
  end

  get "/exercises/new" do
    @workouts = current_user.workouts
    erb :"exercises/new"
  end

  post "/exercises" do
    workout = current_user.workouts.find_by_id(params[:workout_id])
    binding.pry
    exercise = workout.exercises.build(params[:exercise])
    exercise.user = current_user
    exercise.save
    redirect "/exercises"
  end
end