class RemindersController < ApplicationController
  # GET /reminders
  # GET /tasks/:task_id/reminders
  # GET /events/:event_id/tasks/:task_id/reminders
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of reminders for user or task with given token
  def index
    if params[:task_id]
      @task = Task.find(params[:task_id])
      if (@task.taskable_type == "User" && @task.taskable == @current_user) ||
         (@task.taskable_type == "Event" && @task.taskable == Event.find(params[:event_id]))
        render json: @task.reminders
      else
        render json: { error: "No such task for user" }, status: :unauthorized
      end
    elsif
      render json: @current_user.reminders
    end
  end

  # POST /reminders
  # POST /tasks/:task_id/reminders
  # POST /events/:event_id/tasks/:task_id/reminders
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   reminder:
  #     reminder_date: date of reminder "YYYY-MM-DD"
  #     details: details of reminder
  # Returns (JSON):
  #   Reminder object if save is successful
  def create
    if params[:task_id]
      @task = Task.find(params[:task_id])
      if (@task.taskable_type == "User" && @task.taskable == @current_user) ||
         (@task.taskable_type == "Event" && @task.taskable == Event.find(params[:event_id]))
        @reminder = @task.reminders.create(reminder_params)
        render json: @reminder
      else
        render json: { error: "No such task for user" }, status: :unauthorized
      end
    elsif
      @reminder = @current_user.reminders.create(reminder_params)
      render json: @reminder
    end
  end

  # PATCH /reminders/:id
  # PATCH /tasks/:task_id/reminders/:id
  # PATCH /events/:event_id/tasks/:task_id/reminders/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   task:
  #     attribute names of reminder and their values to be updated
  # Returns (JSON):
  #   Updated reminder object if save is successful
  def update
    @reminder = Reminder.find(params[:id])
    if (@reminder.remindable_type == "User" && @reminder.remindable == @current_user) ||
       (@reminder.remindable_type == "Task" && @reminder.remindable == Task.find(params[:task_id]))
      @reminder.update(reminder_params)
      render json: @reminder
    else
      render json: { error: "No such reminder for user" }, status: :unauthorized
    end
  end

  # GET /reminders/:id
  # GET /tasks/:task_id/reminders/:id
  # GET /events/:event_id/tasks/:task_id/reminders/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether reminder was deleted successfully or not
  def destroy
    @reminder = Reminder.find(params[:id])
    if (@reminder.remindable_type == "User" && @reminder.remindable == @current_user) ||
       (@reminder.remindable_type == "Task" && @reminder.remindable == Task.find(params[:task_id]))
      @reminder.destroy
      render json: { success: "Reminder deleted successfully" }
    else
      render json: { error: "No such reminder for user" }, status: :unauthorized
    end
  end

  private
    def reminder_params
      params.require(:reminder).permit(:reminder_date, :details)
    end
end
