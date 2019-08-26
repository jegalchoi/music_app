class BandsController < ApplicationController
  before_action :require_user!

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:success] = "Band successfully added!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def show
    find_band
    @albums = Album.where(band_id: @band.id)
  end

  def destroy
    find_band
    @band.destroy
    redirect_to bands_url
  end

  def edit
    find_band
  end

  def update
    find_band

    if @band.update_attributes(band_params)
      flash[:success] = "Band successfully updated!"
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def find_band
    @band = Band.find_by(id: params[:id])
  end
end