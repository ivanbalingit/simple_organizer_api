class NotesController < ApplicationController
  # GET /notes
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   List of notes for user with given token
  def index
    render json: @current_user.notes
  end

  # POST /notes
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   note:
  #     note_text: content of note
  # Returns (JSON):
  #   Note object if save is successful
  def create
    @note = @current_user.notes.create(note_params)
    render json: @note
  end

  # PATCH /notes/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  #   Content-Type: application/json
  # Body Contents (JSON):
  #   note:
  #     attribute names of note and their values to be updated
  # Returns (JSON):
  #   Updated note object if save is successful
  def update
    @note = Note.find(params[:id])
    if @note.user == @current_user
      @note.update(note_params)
      render json: @note
    else
      render json: { error: "No such note for user" }, status: :unauthorized
    end
  end

  # DELETE /notes/:id
  # Required Headers:
  #   Authorization: token of user from authentication
  # Returns (JSON):
  #   Message whether note was deleted successfully or not
  def destroy
    @note = Note.find(params[:id])
    if @note.user == @current_user
      @note.destroy
      render json: { success: "Note deleted successfully" }
    else
      render json: { error: "No such note for user" }, status: :unauthorized
    end
  end

  private
    def note_params
      params.require(:note).permit(:note_text)
    end
end
