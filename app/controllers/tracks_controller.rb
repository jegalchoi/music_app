class TracksController < ApplicationController
  before_action :require_user!
  
  def new
    @track = Track.new
    find_album_by_params
    find_albums
  end

  def create
    @track = Track.new(track_params)
    find_album_by_track    
    find_albums

    if @track.save
      flash[:success] = "Track successfully added!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    find_track
    find_album_by_track
    find_notes_by_track
  end

  def destroy
    find_track
    find_album_by_track
    @track.destroy
    redirect_to album_url(@album)
  end

  def edit
    find_track
    find_album_by_track
    find_albums
  end

  def update
    @track = Track.new(track_params)
    find_album_by_track

    if @track.update_attributes(track_params)
      flash[:success] = "Track successfully updated!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :bonus_track)
  end

  def find_track
    @track = Track.find_by(id: params[:id])
  end

  def find_album_by_track
    @album = Album.find_by(id: @track.album_id)
  end

  def find_album_by_params
    @album = Album.find_by(id: params[:album_id])
  end

  def find_albums
    @albums = Album.all
  end

  def find_notes_by_track
    @notes = Note.where(track_id: @track.id)
  end

end