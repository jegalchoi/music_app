class NotesController < ApplicationController
  before_action :author?, only: [:destroy]

  def create
    @note = Note.new(note_params)
    find_track
    @note.user_id = current_user.id

    if @note.save
      flash[:success] = "Note successfully added!"
      redirect_to track_url(@note.track_id)
    else
      flash.now[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @track = Track.find_by(id: @note.track_id)
    @note.destroy
    redirect_to track_url(@track)
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :body)
  end

  def find_track
    @track = Track.find_by(id: params[:id])
  end

  def author?
    @note = Note.find_by(id: params[:id])
    if current_user.id != @note.user_id 
      render plain: "User not allowed to delete note.", :status => 403
    end
  end
end