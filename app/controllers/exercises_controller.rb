class ExercisesController < ApplicationController

  get "/exercises" do
    @exercises = current_user.exercises
    erb :"exercises/index"
  end

end