class WorkoutsController < ApplicationController
  get "/workouts" do
    redirect_if_not_logged_in
    @workouts = current_user.workouts.order(created_at: :desc)
    erb :"workouts/index"
  end

  get "/workouts/new" do
    redirect_if_not_logged_in
    error_check
    erb :"workouts/new"
  end

  # the clone feature was not required for the project but was added for a fun challenge,
  # it allows you to duplicate a workout created by another user 

  post "/workouts" do
    if params[:clone_id]
      old_workout = Workout.find_by_id(params[:clone_id])
      workout = old_workout.dup
      workout.user_id = current_user.id
      workout.save
      old_workout.exercises.each do |e|
        new_exercise = e.dup
        new_exercise.workout_id = workout.id
        new_exercise.save
      end
      redirect "/workouts"
    else
      workout = current_user.workouts.create(params[:workout])
      if workout.invalid?
        log_errors(workout)
        redirect "/workouts/new"
      end
      exercise = workout.exercises.create(params[:exercise])
      log_errors(exercise)
      redirect "/workouts/#{ workout.id }"
    end
  end

  get "/workouts/community" do
    redirect_if_not_logged_in
    @workouts = Workout.all.order(created_at: :desc)
    erb :"workouts/community"
  end

  get "/workouts/:id" do
    redirect_if_not_logged_in
    error_check
    @workout = current_user.workouts.find_by_id(params[:id])
    redirect "/workouts" if !@workout
    @exercises = Exercise.all
    erb :"workouts/show"
  end

  get "/workouts/:id/edit" do
    redirect_if_not_logged_in
    @workout = current_user.workouts.find_by_id(params[:id])
    @exercises = Exercise.all
    redirect "/workouts" if !@workout
    erb :"workouts/edit"
  end

  patch "/workouts/:id" do
    workout = current_user.workouts.find_by_id(params[:id])
    redirect "/workouts" if !authorized_to_edit?(workout)
    workout.update(params[:workout])
    log_errors(workout)
    redirect "/workouts/#{ workout.id }"
  end

  delete "/workouts/:id/delete" do
    workout = current_user.workouts.find_by_id(params[:id])
    redirect "/workouts" if !authorized_to_edit?(workout)
    if workout
      Exercise.where(workout_id: workout.id).delete_all
      workout.delete
    end        
    redirect "/workouts"
  end
end