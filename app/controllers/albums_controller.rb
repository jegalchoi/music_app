class AlbumsController < ApplicationController
  before_action :require_user!

  def new
    @album = Album.new
    @band = Band.find_by(id: params[:band_id])
    find_bands
  end

  def create
    @album = Album.new(album_params)
    find_band_by
    find_bands
    
    if @album.save
      flash[:success] = "Album successfully added!"
      redirect_to band_url(@band)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    find_album
    find_band
    @tracks = Track.where(album_id: @album.id)
  end

  def destroy
    find_album
    find_band
    @album.destroy
    redirect_to band_url(@band)
  end

  def edit
    find_album
    find_band
    find_bands
  end

  def update
    @album = Album.new(album_params)
    find_band

    if @album.update_attributes(album_params)
      flash[:success] = "Album successfully updated!"
      redirect_to band_url(@band)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end

  def find_album
    @album = Album.find_by(id: params[:id])
  end

  def find_band
    @band = Band.find_by(id: @album.band_id)
  end

  def find_bands
    @bands = Band.all
  end
end