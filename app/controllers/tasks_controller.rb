class TasksController < ApplicationController
  # GET /tasks
  # GET /events/:event_id/tasks
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of tasks for user or event with given token
  def index
    if params[:event_id]
      @event = Event.find(params[:event_id])
      if @event.user == current_user
        render json: @event.tasks
      else
        render json: { error: "No such event for user" }, status: :unauthorized
      end
    else
      render json: @current_user.tasks
    end
  end

  # POST /tasks
  # POST /events/:event_id/tasks
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   task:
  #     name: name of task
  #     due_date: due date of task "YYYY-MM-DD"
  #     details: details of task
  # Returns (JSON):
  #   Task object if save is successful
  def create
    if params[:event_id]
      @event = Event.find(params[:event_id])
      if @event.user == current_user
        @task = @event.tasks.create(task_params)
        render json: @task
      else
        render json: { error: "No such event for user" }, status: :unauthorized
      end
    else
      @task = @current_user.tasks.create(task_params)
      render json: @task
    end
  end

  # PATCH /tasks/:id
  # PATCH /events/:event_id/tasks/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   task:
  #     attribute names of tasks and their values to be updated
  # Returns (JSON):
  #   Updated task object if save is successful
  def update
    @task = Task.find(params[:id])
    if (@task.taskable_type == "User" && @task.taskable == @current_user) ||
       (@task.taskable_type == "Event" && @task.taskable == Event.find(params[:event_id]))
      @task.update(task_params)
      render json: @task
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  # DELETE /tasks/:id
  # DELETE /events/:event_id/tasks/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether task was deleted successfully or not
  def destroy
    @task = Task.find(params[:id])
    if (@task.taskable_type == "User" && @task.taskable == @current_user) ||
       (@task.taskable_type == "Event" && @task.taskable == Event.find(params[:event_id]))
      @task.destroy
      render json: { success: "Task deleted successfully" }
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  private
    def task_params
      params.require(:task).permit(:name, :due_date, :details)
    end
end
