class ExercisesController < ApplicationController

  get "/templates" do
    redirect_if_not_logged_in
    @templates = Template.all
    erb :"templates/index"
  end

  get "/templates/new" do
    redirect_if_not_logged_in
    error_check
    erb :"templates/new"
  end

  post "/templates" do
    @template = Template.create(params[:template])
    log_errors(template)
    redirect "/workouts/#{ template }/edit"
  end

  # get "/templates/:id" do
  #   redirect_if_not_logged_in
  #   @template = current_user.templates.find_by_id(params[:id])
  #   redirect "/templates" if !@template
  #   erb :"templates/show"
  # end

  # get "/templates/:id/edit" do
  #   redirect_if_not_logged_in
  #   error_check
  #   @workouts = current_user.workouts
  #   @template = current_user.templates.find_by_id(params[:id])
  #   redirect "/templates" if !@template
  #   erb :"templates/edit"
  # end

  # patch "/templates/:id" do
  #   template = Template.find_by_id(params[:id])
  #   redirect "/workouts" if !authorized_to_edit?(template.workout)
  #   if params[:template][:workout_id] == ""
  #     session[:errors] = ["Please select a workout from the dropdown"]
  #     redirect "/templates/#{ template.id }/edit"
  #   end
  #   template.update(params[:template])
  #   redirect "/workouts/#{ template }"
  # end

  # delete "/templates/:id/delete" do
  #   template = Template.find_by_id(params[:id])
  #   redirect "/workouts" if !authorized_to_edit?(template.workout)
  #   workout_id = template
  #   template.delete if template
  #   redirect "/workouts/#{ workout_id }/edit"
  # end
end