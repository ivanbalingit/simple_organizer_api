class SubtasksController < ApplicationController
  # GET /tasks/:task_id/subtasks
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of subtasks for task of user with given token
  def index
    @task = Task.find(params[:task_id])
    if @task.user == @current_user
      render json: @task.subtasks
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end
  
  # POST /tasks/:task_id/subtasks
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   subtask:
  #     name: name of subtask
  # Returns (JSON):
  #   Subtask object if save successful
  def create
    @task = Task.find(params[:task_id])
    if @task.user == @current_user
      @subtask = @task.subtasks.create(subtask_params)
      render json: @subtask
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  # PATCH /tasks/:task_id/subtasks/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   subtask:
  #     attribute names of subtask and their values to be updated
  # Returns (JSON):
  #   Updated subtask object if save is successful
  def update
    @task = Task.find(params[:task_id])
    @subtask = Subtask.find(params[:id])
    if @task.user == @current_user && @subtask.task = @task
      @subtask.update(subtask_params)
      render json: @subtask
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  # DELETE /tasks/:task_id/subtasks/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether subtask was deleted successfully or not
  def destroy
    @task = Task.find(params[:task_id])
    @subtask = Subtask.find(params[:id])
    if @task.user == @current_user && @subtask.task = @task
      @subtask.destroy
      render json: { success: "Subtask deleted successfully" }
    else
      render json: { error: "No such task for user" }, status: :unauthorized
    end
  end

  private
    def subtask_params
      params.require(:subtask).permit(:name)
    end
end
