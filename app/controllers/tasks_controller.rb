class TasksController < ApplicationController
  # GET /tasks
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of tasks for user with given token
  def index
    render json: @current_user.tasks
  end

  # POST /tasks
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
    @task = @current_user.tasks.create(task_params)
    render json: @task
  end

  # PATCH /tasks/:id
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
    if @task.user == @current_user
      @task.update(task_params)
      render json: @task
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  # DELETE /tasks/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether task was deleted successfully or not
  def destroy
    @task = Task.find(params[:id])
    if @task.user == @current_user
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
