class EventsController < ApplicationController
  # GET /events
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of events for user with given token
  def index
    render json: @current_user.events
  end

  # POST /events
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   event:
  #     name: name of event
  #     event_date: date of event "YYYY-MM-DD"
  #     time_start: start time of event "HH:MM"
  #     time_end: end time of event "HH:MM"
  #     details: other details for event
  # Returns (JSON):
  #   Event object if save is successful
  def create
    @event = @current_user.events.create(event_params)
    render json: @event
  end

  # PATCH /events/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   event:
  #     attribute names of event and their values to be updated
  # Returns (JSON):
  #   Updated task object if save is successful
  def update
    @event = Event.find(params[:id])
    if @event.user == @current_user
      @event.update(event_params)
      render json: @event
    else
      render json: { error: "No such event for user" }, status: :unauthorized
    end
  end

  # DELETE /events/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether event was deleted successfully or not
  def destroy
    @event = Event.find(params[:id])
    if @event.user == @current_user
      @event.destroy
      render json: { success: "Event deleted successfully" }
    else
      render json: { error: "No such event for user" }, status: :unauthorized
    end
  end

  private
    def event_params
      params.require(:event).permit(:name, :event_date, :time_start, :time_end, :details)
    end
end
