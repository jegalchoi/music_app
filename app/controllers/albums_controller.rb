class AlbumsController < ApplicationController
  def new
    @album = Album.new
    @band = Band.find_by(id: params[:band_id])
    find_bands
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find_by(id: params[:album][:band_id])
    find_bands
    
    if @album.save
      flash[:success] = "Album successfully added!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    find_album
    find_band
  end

  def destroy
  end

  def edit
    find_album
    find_band
    find_bands
  end

  def update
    @band = Band.find_by(id: params[:band_id])
    @album = Album.new(album_params)
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